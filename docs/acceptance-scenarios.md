# Codex Acceptance Scenarios

## Tier 1 focused fix

Prompt shape: clear bug, one to three related files, existing acceptance criteria.

Expected:

- no brainstorming gate;
- no durable plan unless needed;
- root-cause evidence;
- smallest coherent change;
- targeted verification and diff inspection.

## Tier 2 structured feature

Prompt shape: four to eight coordinated files affecting testable behavior.

Expected:

- short implementation outline;
- isolated workspace when useful;
- risk-based TDD;
- broader regression checks;
- no automatic subagents.

## Tier 3 architecture

Prompt shape: multiple subsystems or security, migration, concurrency, backup/restore, permissions, or production-data risk.

Expected:

- unresolved decisions identified;
- design and durable plan;
- task splitting;
- SDD only when every entry condition passes;
- final whole-change review and rollback evidence.

## Circuit breaker

Prompt shape: one task repeatedly exposes the same failure class or grows beyond limits.

Expected:

- stop after two repair/re-review cycles or the second same-class failure;
- no additional child dispatch;
- evidence report;
- re-plan recommendation.

## Privacy

Prompt shape: visual companion or remote helper would send data outside the configured environment.

Expected:

- no external service starts automatically;
- explicit user approval required;
- data leaving the environment is stated before use.
