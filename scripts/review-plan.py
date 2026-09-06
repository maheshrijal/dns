#!/usr/bin/env python3
"""Summarize a plan and bind approval to its commit and intended state changes."""
import argparse
import hashlib
import json
import os
import sys


def fingerprint(plan, commit):
    # Exclude run timestamps; retain all planned values, drift and actions.
    payload = {key: plan.get(key) for key in (
        "planned_values", "resource_changes", "resource_drift", "output_changes"
    )}
    payload["commit"] = commit
    return hashlib.sha256(json.dumps(payload, sort_keys=True, separators=(",", ":")).encode()).hexdigest()


def check_import(plan, expected):
    changes = plan.get("resource_changes", [])
    if any(r["change"]["actions"] != ["no-op"] for r in changes):
        raise ValueError("Import requires zero resource creates, updates or deletes")
    count = sum(bool(r["change"].get("importing")) for r in changes)
    if count != expected:
        raise ValueError(f"Expected {expected} imports, found {count}")
    if plan.get("errored") or plan.get("complete") is False:
        raise ValueError("Plan is errored or incomplete")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("plan")
    parser.add_argument("--expect")
    parser.add_argument("--imports", type=int)
    args = parser.parse_args()
    with open(args.plan) as source:
        plan = json.load(source)
    digest = fingerprint(plan, os.environ["GITHUB_SHA"])
    print(f"Reviewed plan fingerprint: {digest}")
    if args.imports is not None:
        check_import(plan, args.imports)
    if args.expect is not None and digest != args.expect:
        raise ValueError("Plan differs from the reviewed plan; run plan and review again")
    if summary := os.environ.get("GITHUB_STEP_SUMMARY"):
        with open(summary, "a") as out:
            out.write(f"\nCommit: `{os.environ['GITHUB_SHA']}`\n\nPlan fingerprint: `{digest}`\n")


if __name__ == "__main__":
    try:
        main()
    except ValueError as error:
        sys.exit(str(error))
