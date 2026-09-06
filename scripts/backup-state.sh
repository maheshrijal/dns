#!/usr/bin/env bash
# Copy the exact state object to a unique backup key; fail closed on API errors.
set -euo pipefail
domain=$1
phase=$2
case "$domain" in maheshrijal.com|mrjl.dev) ;; *) exit 2 ;; esac
case "$phase" in before|after) ;; *) exit 2 ;; esac
key="dns/$domain.tfstate"
endpoint=https://5be63f1c67d62926a407c12960d8a087.r2.cloudflarestorage.com
objects=$(aws --endpoint-url "$endpoint" s3api list-objects-v2 \
  --bucket tfstate --prefix "$key" --output json)
count=$(printf '%s' "$objects" | python3 -c \
  'import json,sys; print(sum(o["Key"] == sys.argv[1] for o in json.load(sys.stdin).get("Contents", [])))' "$key")
if [[ "$count" == 0 ]]; then
  if [[ "$phase" == before && "${MIGRATION_OPERATION:-}" == import ]]; then
    echo "No previous state exists; first import."
    exit 0
  fi
  echo "Expected state object is missing: $key" >&2
  exit 1
fi
backup="backups/$domain/$(date -u +%Y%m%dT%H%M%SZ)-${GITHUB_RUN_ID}-${GITHUB_RUN_ATTEMPT}-$phase.tfstate"
aws --endpoint-url "$endpoint" s3api copy-object --bucket tfstate \
  --copy-source "tfstate/$key" --key "$backup" >/dev/null
echo "State backed up to tfstate/$backup"
