---
name: subagent-driven-development
description: Use only for an approved implementation plan with several bounded, mostly independent tasks that benefit from isolated implementer and reviewer context. Includes strict size, retry, and cost circuit breakers.
---

# Bounded Subagent-Driven Development

## Purpose

Use subagents where isolation and independent review improve quality. Do not use them for work that one agent can complete safely with less coordination cost.

## Entry gate

All conditions must be true:

- an approved implementation plan exists;
- the plan contains at least 2 genuinely independent tasks;
- each task has clear acceptance criteria and verification;
- each task is expected to touch no more than 8 files;
- each task brief is no more than 300 lines;
- no task combines unrelated subsystems;
- the environment supports subagents reliably.

Do not use SDD for:

- one-file or simple three-file changes;
- exploratory debugging without a confirmed root cause;
- tasks whose boundaries are still changing;
- destructive production operations;
- a single large task disguised as one plan item.

If any gate fails, split the task, use inline execution, or return to planning.

## Preflight

Before dispatching Task 1:

1. read the plan and global constraints;
2. detect contradictions and missing interfaces;
3. estimate files, brief size, shared state, and migration risk per task;
4. confirm baseline tests;
5. record the merge base and create a durable progress ledger;
6. verify whether Codex can select a model or agent profile per child.

If per-child model selection is unavailable, state that children inherit the parent configuration. Do not claim cost optimization that the harness cannot enforce.

## Execution model

For each task:

1. generate a task-scoped brief;
2. dispatch one fresh implementer;
3. require implementation, relevant tests, diff self-review, and a concise report;
4. independently inspect the diff and verification evidence;
5. dispatch one task reviewer only when the change is non-trivial or high-risk;
6. resolve Critical and Important findings in one bounded fix pass;
7. mark the task complete in the ledger only after verification.

Do not paste accumulated session history into child prompts. Hand task briefs, reports, and review packages over as files.

## Circuit breakers

Stop the current task and return to the user with evidence when any condition occurs:

- 2 repair or re-review cycles have completed without a clean result;
- the same failure class appears twice;
- the task grows beyond 8 changed files;
- the task brief or required context grows beyond 300 lines;
- one child undergoes context compaction;
- the task crosses an architecture, security, migration, or shared-state boundary not covered by the plan;
- verification requires repeatedly expanding the test matrix;
- the parent cannot determine whether a child is active or blocked;
- elapsed work becomes disproportionate to the task's stated size.

A circuit breaker means **stop and re-plan**. It does not mean dispatch another agent or add another repair loop.

## Concurrency and shared state

After the first ordering, race, or stale-state defect:

- define the state invariants;
- list relevant operation orderings;
- test the complete bounded matrix rather than patching symptoms one by one;
- split the task if more than one component owns the invariant.

## Agent lifecycle

- one task owns one implementer identity;
- do not reuse an implementer for another task;
- close implementer and reviewer agents after their task is complete;
- do not treat mailbox timeout as proof that an agent is inactive;
- do not send repeated wait or follow-up calls without new evidence;
- never run multiple implementation agents against the same files concurrently.

## Review policy

The reviewer must evaluate:

- acceptance-criteria compliance;
- preservation of existing behavior;
- correctness and maintainability;
- unnecessary scope or refactoring;
- verification quality;
- migration, rollback, and security implications where relevant.

Reviewer findings need concrete file and line evidence. The controller must not coach the reviewer to suppress findings.

Minor findings may be recorded for final review. Critical and Important findings block task completion.

## Final review

After all tasks:

1. inspect the whole branch diff from merge base;
2. run the full relevant verification suite;
3. check requirements line by line;
4. verify no existing UI, exports, interfaces, buttons, or compatibility behavior were lost;
5. use one consolidated fix pass for final findings;
6. apply the circuit breaker if the final pass reveals architectural scope growth.

## Completion report

Report:

- completed tasks and commit ranges;
- changed files;
- test and verification commands with results;
- reviewer findings and resolutions;
- circuit breakers approached or triggered;
- unresolved risks;
- branch or PR handoff state.
