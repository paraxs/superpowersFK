---
name: test-driven-development
description: Apply risk-based red-green-refactor or an explicit alternative verification method. Use when changing behavior, business logic, regressions, APIs, persistence, calculations, permissions, retrieval, or other code where a failing test can prove the requirement.
---

# Risk-Based Test-Driven Development

## Core rule

For testable behavior, prove the requirement with a failing test before implementing the fix or feature.

TDD is a confidence mechanism, not a ritual. Choose the cheapest verification that genuinely proves the requested behavior.

## Use strict red-green-refactor for

- business rules and calculations;
- bug fixes with a practical regression test;
- APIs and public interfaces;
- persistence, migrations, imports, and exports;
- authentication and permissions;
- retrieval, ranking, and data transformation;
- concurrency and shared-state behavior;
- refactoring where behavior must remain stable.

## Use another explicit verification method for

- copy-only changes;
- CSS or purely visual adjustments;
- static configuration where no meaningful unit test exists;
- generated files;
- dependency metadata or lockfile-only changes;
- throwaway exploration approved by the user.

Document the chosen verification. Do not create artificial tests that merely assert implementation details or static text without protecting meaningful behavior.

## Red-green-refactor

1. **RED:** Write the smallest test that expresses one required behavior.
2. **Verify RED:** Run it and confirm it fails for the expected reason.
3. **GREEN:** Implement the smallest coherent production change.
4. **Verify GREEN:** Run the targeted test and relevant surrounding tests.
5. **REFACTOR:** Improve structure only when needed, keeping tests green.
6. **Inspect diff:** Confirm no unrelated behavior changed.

## Existing code and emergency fixes

- Do not delete valid existing implementation solely because tests were written later.
- When a bug is already fixed during diagnosis, create a regression test and prove it by temporarily reverting or isolating the fix when practical.
- If reproducing RED would endanger production data or require destructive actions, use a safe fixture, sandbox, or characterization test instead.
- Never run destructive tests against production systems.

## Test quality

A useful test:

- names the behavior clearly;
- exercises real code where practical;
- fails for one understandable reason;
- protects the public outcome rather than incidental implementation;
- is deterministic and repeatable;
- adds value proportional to its maintenance cost.

Avoid:

- excessive mocks that test the mock rather than the system;
- broad snapshot tests with unclear intent;
- duplicate tests that protect the same path;
- tests that pass before the requested behavior exists;
- changing a valid requirement merely to make a test pass.

## Scope and escalation

Stop and re-plan when:

- the code is untestable because responsibilities are entangled;
- two attempts reveal the same failure class;
- a focused fix requires an unrelated architectural rewrite;
- tests expose conflicting requirements;
- the test surface expands beyond the assigned task.

Report the evidence and propose the smallest safe boundary change.

## Completion evidence

Before claiming completion, report:

- test or verification command;
- observed RED evidence when TDD applies;
- final passing output;
- broader checks run;
- any behavior not covered and why.
