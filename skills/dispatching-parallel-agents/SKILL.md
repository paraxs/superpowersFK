---
name: dispatching-parallel-agents
description: Coordinate parallel agents for independent, non-overlapping investigations or tasks. Use when at least two work items have no shared state, file ownership, ordering dependency, or unresolved common root cause.
---

# Dispatching Parallel Agents

## Purpose

Parallelize only work whose independence is already established. Coordination cost and shared-state risk must remain lower than the expected time saved.

## Entry gate

All conditions must be true:

- at least two work items can proceed independently;
- one result cannot invalidate the premise of another;
- agents will not edit the same files or mutate the same external state;
- each task has a clear scope, output, and stop condition;
- the runtime supports concurrent agents reliably;
- the parent can independently verify and integrate every result.

Do not dispatch parallel agents for exploratory debugging when failures may share one root cause. Investigate the relationship first.

## Choose investigation or implementation

### Parallel investigation

Use read-only agents to inspect separate logs, failing test groups, components, or hypotheses. Require evidence and prohibit edits.

### Parallel implementation

Use only when task boundaries are approved and file ownership is disjoint. If the work belongs to an implementation plan, also apply the complete `subagent-driven-development` entry gate and circuit breakers.

Never run multiple implementers against the same checkout state or files without an isolation strategy that the host supports.

## Prepare each task

Give each agent:

- one problem domain;
- concrete files, errors, or artifacts;
- relevant repository constraints;
- explicit read/write boundaries;
- verification expectations;
- required output format;
- stop conditions for scope growth or uncertainty.

Pass task-local context, not the parent session history or an expected conclusion.

## Dispatch

Start independent tasks together only after all briefs are ready. Do not reuse one child identity for unrelated tasks.

If the runtime cannot prove that agents are isolated or active, fall back to sequential work.

## Integrate

After results return:

1. Read every report and inspect the underlying evidence.
2. Confirm agents did not overlap or contradict one another.
3. Review every diff from the recorded merge base.
4. Run combined verification.
5. Check requirements and preserved behavior.
6. Close or release completed agents when the runtime provides that operation.

An agent report is not verification.

## Stop conditions

Stop parallel work and re-plan when:

- a shared root cause appears;
- two tasks require the same files or state;
- one task expands across architecture, security, migration, or shared-state boundaries;
- an agent becomes indeterminate after repeated status checks;
- integration reveals ordering or race defects;
- expected coordination cost becomes disproportionate.

Report the evidence instead of dispatching replacement agents around the problem.

## Completion report

Report task ownership, agent results, integration checks, conflicts, verification commands, and remaining risks.
