---
name: executing-plans
description: Execute an approved implementation plan with proportional checkpoints, verification, and scope control. Use when a durable plan already exists and inline execution is safer or cheaper than multi-agent coordination.
---

# Executing Plans

## Purpose

Execute an approved plan without turning the plan into an excuse for ceremony, scope growth, or unnecessary delegation.

## Entry conditions

Use this skill when:

- a written implementation plan exists;
- requirements and task boundaries are sufficiently clear;
- the work should continue in the current session;
- `subagent-driven-development` is unavailable or its complete entry gate does not pass.

If two or more genuinely independent tasks pass the SDD entry gate and delegation adds clear value, use `subagent-driven-development`. Subagent availability alone is not a reason to delegate.

## Process

### 1. Review the plan

- Read the plan, repository instructions, and current workspace state.
- Map every acceptance criterion to a task.
- Identify missing interfaces, unsafe assumptions, or commands that no longer match the repository.
- Resolve only material blockers before starting; do not reopen settled requirements.

### 2. Establish the baseline

- Record the merge base and current branch.
- Use `using-git-worktrees` only when isolation is justified and not already provided.
- Run the narrowest relevant baseline verification.
- Do not modify dependencies or lockfiles merely to prepare the workspace.

### 3. Execute task by task

For each task:

1. Mark it in progress.
2. Confirm its file and interface boundary.
3. Apply risk-based testing or the explicit alternative verification in the plan.
4. Make the smallest coherent change.
5. Run targeted and relevant surrounding checks.
6. Inspect the task diff before marking it complete.

Commit only when commits are part of the requested workflow. Never silently expand the task.

### 4. Apply stop conditions

Stop and revise the plan when:

- evidence contradicts a requirement or interface;
- the task crosses an unplanned architecture, security, migration, or shared-state boundary;
- the same failure class appears twice;
- more than two repair/re-review cycles would be required;
- a task exceeds its approved size or becomes disproportionate.

Report the evidence and smallest safe decision instead of guessing.

### 5. Complete the plan

- Inspect the whole diff from the merge base.
- Run the full relevant verification suite.
- Check acceptance criteria line by line.
- Record remaining risks and unverified behavior.
- Use `finishing-a-development-branch` only when branch integration or PR handling is actually requested.

## Completion report

Report:

- completed tasks;
- changed files;
- verification commands and observed results;
- deviations from the plan;
- stop conditions approached or triggered;
- remaining risks and branch state.
