# DNS

OpenTofu manages existing Cloudflare DNS records for `maheshrijal.com` and
`mrjl.dev`. Each domain is an independent root configuration with its own state
and lock in the private Cloudflare R2 bucket `tfstate`:

| Root directory | R2 state key | Baseline imports |
| --- | --- | --- |
| `domains/maheshrijal.com` | `dns/maheshrijal.com.tfstate` | 25 |
| `domains/mrjl.dev` | `dns/mrjl.dev.tfstate` | 14 |

Use OpenTofu **1.12.6**. Cloudflare provider **4.39.0** is deliberately retained
from the old setup; upgrading the provider is a separate migration. Lock files
include Linux amd64 (Actions) and macOS arm64 checksums.

## Ownership

The baseline was exported from live Cloudflare DNS with `cf` on 2026-09-06.
It preserves content, proxy settings, TTLs, priorities and comments. Import
blocks identify existing record IDs, including records recreated since the
old Terraform Cloud state was used. Keep the blocks after import; they are
idempotent for records already in state.

These records are marked `read_only` by Cloudflare and remain managed through
their owning services, not as `cloudflare_record` resources:

| Record | Owner |
| --- | --- |
| `assets.maheshrijal.com` | R2 bucket `assets` custom domain |
| `static.mrjl.dev` | R2 bucket `static` custom domain |
| `tickmcp.mrjl.dev` | Worker custom domain |
| `tickmcp-dev.mrjl.dev` | Worker custom domain |

This repo does not manage Pages projects, Workers, R2 buckets/custom-domain
bindings, redirects, registrar settings or nameservers. The state bucket is
created separately and is not a resource in either state.

## Credentials

`cf` login is used for discovery/exports; it does not automatically authenticate
OpenTofu's provider or the S3 backend. Never commit tokens, state or plans.
The account and zone IDs in the configuration are identifiers, not credentials.

For local use, supply credentials through a password manager or environment:

- `CLOUDFLARE_API_TOKEN`: Cloudflare token for the target zone. DNS plans need
  read access; applies need DNS edit access. Prefer an account-owned token for CI.
- `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`: R2 S3 credentials, scoped to
  bucket `tfstate`. Read-only plans need Object Read; applies and lock operations
  require Object Read & Write. This is separate from the DNS API token.

For GitHub Actions:

| Location | Secret | Purpose |
| --- | --- | --- |
| Repository | `CLOUDFLARE_DNS_READ_TOKEN` | Read DNS for both zones |
| Repository | `R2_READ_ACCESS_KEY_ID`, `R2_READ_SECRET_ACCESS_KEY` | Object Read on `tfstate` |
| Environment `dns-maheshrijal.com` | `CLOUDFLARE_DNS_TOKEN` | DNS edit for only `maheshrijal.com` |
| Environment `dns-mrjl.dev` | `CLOUDFLARE_DNS_TOKEN` | DNS edit for only `mrjl.dev` |
| Both environments | `R2_ACCESS_KEY_ID`, `R2_SECRET_ACCESS_KEY` | Object Read & Write on `tfstate` |

Configure **required reviewers** and **main-only deployment branches** on both
GitHub environments before enabling applies. Enable repository variable
`DNS_PLAN_ENABLED=true` once the read credentials exist. Leave
`DNS_APPLY_ENABLED` unset/false until migration approval and the lock test below.
No credentials or environment settings are created by this repository.

Read credentials are exposed to code in same-repository PR jobs. Only trusted
contributors should have branch write access. Fork PRs get credential-free
validation only. Never use `pull_request_target` to execute PR code with secrets.
Live plans are read-only (`-lock=false`); concurrent changes can make them stale.
Plans are recalculated and checked against the reviewed fingerprint before apply.
Plan summaries/logs include DNS values in this public repo; binary/JSON state and
plan files are not uploaded as artifacts. Do not place private secrets in records.

## Migration: establish fresh state without changing DNS

1. Before any import, disable the legacy Terraform Apply workflow in GitHub.
   The legacy GitHub Apply workflow was disabled on 2026-09-06.
   This PR removes both legacy workflow files; verify it stays disabled until merge. Ensure Terraform Cloud has no VCS-triggered,
   scheduled or pending applies. Preserve its old state if still accessible;
   do not destroy the old workspace's resources.
2. Export both zones again with the authenticated `cf` CLI and save JSON/BIND
   copies privately. Compare against this baseline if migration happens later:

   ```sh
   cf dns records list --zone maheshrijal.com --per-page 5000
   cf dns records export --zone maheshrijal.com
   cf dns records list --zone mrjl.dev --per-page 5000
   cf dns records export --zone mrjl.dev
   ```

   If needed, supply `CLOUDFLARE_ACCOUNT_ID` for account
   `5be63f1c67d62926a407c12960d8a087`. Save exports outside the public repo.
3. Verify the existing `tfstate` bucket is private and the destination keys are
   absent. If either key exists, inspect it and back it up before proceeding;
   do not overwrite or force-push state. Never migrate the stale Terraform Cloud
   state into these keys. Import existing live IDs into the fresh states instead.
4. With explicit approval for temporary R2 writes, test locking using a disposable
   configuration and key under `lock-tests/`, outside the two DNS state keys.
   Hold the lock with one OpenTofu process and verify a second process targeting
   the same key fails to acquire it. Confirm normal release allows retry. Review
   and approve cleanup of only those test objects. This test is a prerequisite,
   not something `init -backend=false` or validation proves.
5. Merge the reviewed configuration PR after approval. Run the **DNS** workflow
   manually on `main`, operation **plan**, for one domain. Review the full plan:
   it must show **25 imports** or **14 imports**, and **0 add, 0 change, 0 destroy**.
   Record the commit and fingerprint from the run summary. Imports may expose
   provider normalization differences; resolve those before continuing.
6. After explicit approval of that plan, enable `DNS_APPLY_ENABLED=true`, then
   dispatch **import** for that domain at the same main commit and paste its
   fingerprint. Approve the protected environment deployment. The workflow
   rejects any DNS mutation, unexpected import count, or changed fingerprint,
   backs up any existing state, then applies the saved plan with state locking.
   Only state is established; live records must not change. Repeat for the other
   domain after checking the first.
7. Verify the resulting plan is empty, and compare another `cf` export with the
   pre-import baseline. Check authoritative/public DNS and the website/mail paths
   separately: a clean OpenTofu plan alone does not prove resolution or delivery.

Local read-only plan equivalent (run separately for each domain):

```sh
tofu -chdir=domains/maheshrijal.com init -lockfile=readonly
tofu -chdir=domains/maheshrijal.com plan -lock=false
```

No successful live import plan or R2 lock-contention test has been recorded yet.
The preparation checks do not use the live backend or provider credentials.

## Routine changes

Edit the appropriate domain's `records.tf` in a PR. Credential-free format and
validation checks run for both small roots. Once enabled, live read-only plans
run for same-repository PRs and `main`. Weekly drift checks fail when changes are
found. A scheduled check reports drift; it never applies it.

After merging with approval, run **plan** on `main` for the desired domain, review
its actions and fingerprint, then explicitly dispatch **apply** using that
fingerprint and approve the environment. There is no automatic apply on merge.
Changes to the commit, planned values, actions or detected drift invalidate the
fingerprint. Run a new plan and review again if it differs. State locking and
OpenTofu's saved-plan staleness check additionally protect the apply.

Writes are serialized per domain in Actions. Native `.tflock` objects also
coordinate local runs. Do not bypass locking or use force-unlock while another
writer is active. Before/after backups assume all routine writes use this
workflow; arrange equivalent backups and avoid concurrent writes for local
emergency work. Reverting a Git commit is not an automatic rollback: review and
apply the resulting DNS plan.

## State backups and recovery

R2 does not implement S3 bucket versioning. Every workflow apply copies the current
state before and after the operation to unique keys:

```text
backups/<domain>/<UTC timestamp>-<run ID>-<attempt>-before.tfstate
backups/<domain>/<UTC timestamp>-<run ID>-<attempt>-after.tfstate
```

The first import has no preexisting state to copy. Failed applies attempt an
after backup too. Retain these objects; do not add lifecycle deletion without
an explicit retention decision. Same-bucket copies protect against accidental
state replacement, not loss of the bucket or compromised bucket credentials.
Keep an independent private export before migrations and recovery operations.

To recover, stop writers, save the current object, inspect candidate backup
lineage/serial and compare record IDs against live DNS. Show the exact restoration
and rollback material for approval before overwriting any state. Restoring an
old state does not restore DNS and can produce destructive plans. Never blindly
use `tofu state push -force`, delete `.tflock`, or run `destroy` during recovery.

## Local checks

```sh
tofu fmt -check -recursive
tofu -chdir=domains/maheshrijal.com init -backend=false -lockfile=readonly
tofu -chdir=domains/maheshrijal.com validate
tofu -chdir=domains/mrjl.dev init -backend=false -lockfile=readonly
tofu -chdir=domains/mrjl.dev validate
python3 -m unittest discover -s scripts -p 'test_*.py'
actionlint
```
