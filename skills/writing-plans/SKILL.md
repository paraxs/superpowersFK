---
name: writing-plans
description: Use when a Tier 3 change, unresolved interfaces, high-risk rollout, or complex dependency chain makes a short implementation outline insufficient. Do not invoke solely because a Tier 2 change spans several files.
---

# Proportional Implementation Plans

## Purpose

Create an executable plan that reduces uncertainty without duplicating the repository or burying the implementation in ceremony.

## Entry conditions

Use a durable plan when one or more apply:

- the task is Tier 3;
- a Tier 2 outline cannot safely capture task dependencies or interfaces;
- migration, rollback, security, concurrency, permissions, or production data matter;
- multiple independently testable tasks require a durable handoff or staged execution;
- the user explicitly requests a written plan.

Do not invoke solely because a Tier 2 change spans several files. Use the router's short inline outline when requirements, interfaces, and execution order are already settled. Tier 1 work normally needs no plan artifact.

## Required plan header

```markdown
# <Feature> Implementation Plan

**Goal:** <one sentence>
**Scope:** <included behavior>
**Non-goals:** <explicit exclusions>
**Risk tier:** <2 or 3>
**Architecture:** <short approach>
**Verification:** <commands and evidence>
**Rollback:** <how to undo or recover>
```

## Global constraints

Copy binding values and rules exactly from the request, design, and repository instructions. Include:

- compatibility requirements;
- dependency limits;
- data and migration rules;
- naming and copy requirements;
- UI or export behavior that must remain unchanged;
- security and permission boundaries;
- deployment and rollback constraints.

## Task boundaries

Each task must:

- produce one independently testable outcome;
- normally touch no more than 8 files;
- have a task brief of no more than 300 lines;
- define what it consumes and produces;
- identify exact files or discovery anchors;
- state verification and expected results;
- avoid unrelated cleanup.

Split a task when:

- more than one subsystem owns the result;
- shared state or concurrency crosses component boundaries;
- implementation and migration cannot be verified independently;
- the task exceeds the SDD size limits.

## Task format

```markdown
### Task N: <outcome>

**Purpose:** <why this task exists>

**Files:**
- Modify: `path/to/file`
- Create: `path/to/new-file`
- Test: `path/to/test`

**Interfaces:**
- Consumes: <existing contracts>
- Produces: <new or changed contracts>

**Steps:**
1. Establish baseline or failing regression evidence.
2. Make the smallest coherent implementation change.
3. Run targeted verification.
4. Run relevant surrounding regression checks.
5. Inspect the diff and record remaining risk.

**Expected evidence:**
- `<command>` → `<expected outcome>`
```

Include exact code only when the implementation contract truly requires exact content. Do not paste large files into a plan when paths, interfaces, and acceptance criteria are sufficient.

## Testing strategy

Apply risk-based testing:

- strict red-green-refactor for meaningful testable behavior;
- characterization tests for risky legacy behavior;
- visual or manual verification for purely visual changes;
- schema and rollback checks for migrations;
- invariant and ordering matrices for concurrency;
- no destructive verification against production.

## Preflight self-review

Before execution, verify:

1. every acceptance criterion maps to a task;
2. no task exceeds 8 expected changed files or 300 brief lines;
3. interfaces and names are consistent across tasks;
4. no placeholders or vague instructions remain;
5. rollback exists where failure can damage data or deployment;
6. verification commands actually prove the claimed outcome;
7. no task includes unrelated refactoring.

## Execution choice

After the plan:

- use inline execution when tasks are tightly coupled or coordination cost exceeds the benefit;
- use subagent-driven development only when its full entry gate passes;
- do not default to subagents merely because a plan exists.

## Change control

Stop and revise the plan when implementation evidence contradicts it, the task grows beyond its tier, or a circuit breaker triggers. Never silently expand scope during execution.
