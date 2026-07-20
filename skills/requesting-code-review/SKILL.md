---
name: requesting-code-review
description: Prepare and request an independent, evidence-based code review. Use when changes are non-trivial or high-risk, before merging consequential work, or when a fresh reviewer is likely to find issues that focused verification cannot.
---

# Requesting Code Review

## Purpose

Use independent review where it adds measurable confidence. Do not create review ceremony for a focused Tier 1 change that is already well covered by tests and diff inspection.

## Choose the review level

### Self-review

Use for focused, low-risk changes:

- inspect the complete diff;
- compare it with the request;
- run targeted verification;
- check for accidental scope and compatibility changes.

### Independent review

Use when one or more apply:

- architecture, security, migration, permissions, concurrency, or public interfaces changed;
- several components or tasks must integrate;
- the implementation deviates from the plan;
- the user requests review;
- the change is about to merge and a missed defect would be costly.

Use a fresh reviewer context when the runtime supports it reliably. Otherwise perform a separate review pass from the merge-base diff.

## Prepare the review package

Provide:

- concise change description;
- exact requirements or plan path;
- merge-base and head SHAs;
- changed-file list and full diff;
- verification commands and observed results;
- known risks or intentionally unverified behavior.

Use [code-reviewer.md](code-reviewer.md) when dispatching a reviewer. Do not pass accumulated conversation history or conclusions that coach the verdict.

## Review expectations

The reviewer must check:

- acceptance-criteria compliance;
- correctness and preservation of existing behavior;
- unnecessary scope or refactoring;
- test and verification quality;
- security, migration, rollback, and compatibility implications where relevant.

Every blocking finding needs concrete file and line evidence.

## Respond to findings

- Fix Critical findings before proceeding.
- Fix Important findings or provide evidence-based disagreement.
- Record Minor findings when they do not justify more scope.
- Use one bounded repair pass; apply the workflow circuit breaker before a third review cycle.
- Re-run verification for amended behavior.

## Completion

Report the review method, findings, resolutions, remaining risks, and readiness verdict. A reviewer report is evidence to inspect, not proof by itself.
