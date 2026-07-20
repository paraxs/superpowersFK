---
name: brainstorming
description: Resolve important product, architecture, UX, security, data, or integration decisions. Use when material choices remain unresolved or the user explicitly requests design-first exploration; do not invoke for focused fixes or complete specifications.
---

# Proportional Brainstorming

## Purpose

Resolve decisions that materially affect implementation. Do not turn settled requirements into another interview.

## Entry conditions

Use this skill only when at least one condition is true:

- the user explicitly requests brainstorming, alternatives, architecture, or design;
- two or more materially different approaches remain viable;
- architecture, data ownership, security, migration, concurrency, or public interfaces are unsettled;
- the request spans independent subsystems and must be decomposed before implementation.

Do not use this skill when:

- the user supplied clear acceptance criteria or a complete specification;
- the task is a focused bug fix or local change;
- the remaining questions can be answered by inspecting the repository;
- a short implementation outline is sufficient.

## Operating rules

1. Read the relevant repository context first.
2. Reuse every settled requirement. Never ask it again.
3. Ask only questions that can change the design or scope.
4. Ask one decision at a time when interaction is necessary.
5. Present alternatives only when meaningful alternatives exist.
6. Lead with the recommended approach and explain the decisive trade-off.
7. Preserve existing behavior and interfaces unless the user explicitly approves a change.

## Proportional outputs

### Focused design note

Use for one bounded feature or change. Produce:

- goal;
- constraints;
- chosen approach;
- affected components;
- verification strategy;
- unresolved risks.

A separate design file and commit are optional. Do not create them unless they improve execution or the user requests them.

### Full design

Use only for Tier 3 architectural or high-risk work. Cover:

- scope and non-goals;
- architecture and component boundaries;
- data flow and ownership;
- error handling and recovery;
- compatibility and migration;
- security and permissions;
- test and rollout strategy;
- rollback conditions.

Save the design only when durable documentation is useful. Use the repository's preferred location; otherwise use `docs/design/`.

## Approval gates

Require explicit approval before implementation only when the design changes architecture, public behavior, data, security, destructive operations, or a user-selected product direction.

For a focused design note with already-settled requirements, summarize the decision and continue without manufacturing an extra approval loop.

## Scope control

If the work contains multiple independent subsystems, split it before planning. Each resulting unit must be independently testable and reversible.

Stop and escalate when:

- requirements conflict;
- a decision would break existing compatibility;
- the design expands beyond the user's stated goal;
- production data or destructive migration is involved without an explicit rollback plan.

## Transition

After the design:

- use a short implementation outline for bounded Tier 2 work;
- invoke `writing-plans` for Tier 3 work or when several dependent tasks require a durable plan;
- do not invoke planning merely because brainstorming was used.
