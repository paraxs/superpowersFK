---
name: using-codex-workflow
description: Route coding work through the smallest reliable FK workflow while applying repository and user instructions first. Use when starting a coding task to classify risk and select only the skills that add measurable value.
---

# Using Codex Workflow FK

## Purpose

Choose a workflow that is proportional to the task. The goal is reliable software, not ceremony.

**Priority order:**

1. Direct user instructions
2. Repository instructions such as `AGENTS.md`
3. This routing policy
4. Individual skill defaults
5. General agent behavior

Never repeat questions already answered by the prompt, repository, issue, specification, or prior instructions.

## Step 1: Read the operating context

Before changing code:

- identify the repository root, current branch, and workspace state;
- read the nearest applicable `AGENTS.md` or equivalent instructions;
- inspect the files and recent changes relevant to the request;
- preserve existing behavior, UI, exports, and public interfaces unless the request explicitly changes them.

Do not explore unrelated parts of the repository.

## Step 2: Classify the task

### Tier 0 — explanation or inspection

Examples: answer a code question, summarize a diff, inspect architecture, review a plan.

- Do not create a plan, worktree, tests, commits, or subagents unless requested.
- Read only what is needed and report evidence.

### Tier 1 — focused change

Use when all are true:

- requirements and acceptance criteria are clear;
- the change is local and expected to touch at most 3 closely related files;
- no architecture, migration, security boundary, or shared-state redesign is involved.

Default workflow:

1. inspect the relevant code and tests;
2. reproduce or establish evidence for the problem when fixing a bug;
3. make the smallest coherent change;
4. run targeted verification;
5. inspect the diff for accidental changes;
6. report files changed, commands run, results, and remaining risk.

Do **not** automatically invoke brainstorming, writing-plans, worktrees, or subagent-driven development.

### Tier 2 — structured change

Use when one or more apply:

- 4–8 files are likely to change;
- several components must coordinate;
- rollback or migration behavior matters;
- the change modifies business logic, persistence, APIs, retrieval, permissions, or deployment.

Default workflow:

1. write a short implementation outline with boundaries and verification;
2. use an isolated worktree when the current environment is not already isolated;
3. apply risk-based TDD;
4. implement in small reversible commits when commits are part of the task;
5. perform focused review and broader regression verification.

Invoke `writing-plans` only when the outline is not sufficient to execute safely.

### Tier 3 — architectural or high-risk change

Use when one or more apply:

- more than 8 files or multiple independent subsystems are involved;
- architecture or product decisions remain unresolved;
- authentication, authorization, destructive migration, concurrency, security, billing, backup/restore, or production data are affected;
- the user explicitly requests design-first development or multi-agent execution.

Default workflow:

1. use `brainstorming` only for unresolved decisions;
2. create a written design and implementation plan;
3. use an isolated workspace;
4. split work into independently testable tasks;
5. use `subagent-driven-development` only after its preflight limits pass;
6. apply final whole-change review and full relevant verification.

## Skill routing

- Bug, test failure, unexpected behavior: `systematic-debugging`
- Business logic or regression with practical automated tests: `test-driven-development`
- Multi-step work requiring a durable plan: `writing-plans`
- Existing approved plan with bounded independent tasks: `subagent-driven-development`
- Substantial work needing isolation: `using-git-worktrees`
- Before any completion claim: `verification-before-completion`
- Branch integration or PR decision: `finishing-a-development-branch`

A skill is a tool, not a mandatory ritual. Invoke it when its entry conditions are met or the user explicitly requests it.

## Global preservation rules

- Do not rewrite complete files when a targeted edit is sufficient.
- Do not perform unrelated refactoring.
- Do not remove working features, buttons, exports, compatibility behavior, or tests without explicit approval.
- Do not silently change dependencies or lockfiles.
- Do not claim success from an agent report alone; verify independently.
- Do not push, merge, delete, or force-update branches without explicit user intent.

## Escalation

Stop and re-plan instead of continuing when:

- the task grows beyond its assigned tier;
- the same failure class appears twice after attempted fixes;
- more than two repair/re-review cycles are needed;
- the change exceeds 8 files inside one task;
- evidence contradicts the plan or acceptance criteria.

Report the concrete evidence and the smallest safe next decision.
