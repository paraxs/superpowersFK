# Codex Workflow FK — Repository Instructions

## Goal

Maintain a pragmatic, preservation-first Codex skill set. Reliability and evidence matter more than ceremony or autonomous activity.

## Binding priorities

1. Direct user instructions
2. This `AGENTS.md`
3. Skill-specific instructions
4. General agent defaults

Never repeat a question already answered by the request, repository, issue, specification, or previous instruction.

## Change policy

- Preserve working behavior, interfaces, UI, exports, buttons, and compatibility unless a change is explicitly requested.
- Make the smallest coherent change that addresses verified evidence.
- Do not perform unrelated refactoring.
- Do not rewrite complete files when a targeted edit is sufficient.
- Do not silently change dependencies, lockfiles, or deployment behavior.
- Do not run destructive operations against production data.
- Do not push, merge, delete, or force-update branches without explicit user intent.

## Workflow policy

Classify work through `skills/using-superpowers/SKILL.md`.

- Tier 0: inspection only
- Tier 1: focused local change
- Tier 2: structured multi-file change
- Tier 3: architecture or high-risk change

Brainstorming is explicit or decision-driven, never a universal gate.

TDD is risk-based. Use strict red-green-refactor where automated tests protect meaningful behavior. Use explicit alternative verification for purely visual, textual, generated, or configuration-only changes.

Subagent-driven development is allowed only after its entry gate passes. Its circuit breakers are mandatory.

## Multi-agent limits

For each SDD task:

- maximum 8 expected changed files;
- maximum 300 lines in the task brief;
- maximum 2 repair/re-review cycles;
- stop when the same failure class appears twice;
- stop after child context compaction;
- stop when architecture, security, migration, or shared-state boundaries expand;
- never assign one child identity to multiple tasks;
- close completed children.

A triggered circuit breaker requires a report and re-plan. Do not continue by dispatching another agent.

## Verification

Before any completion claim:

- run fresh relevant verification;
- read the complete output and exit status;
- inspect the diff for accidental changes;
- check acceptance criteria line by line;
- report changed files, commands, results, and remaining risks.

An agent report is not verification.

## Privacy and independence

- Do not add telemetry or remote helper services by default.
- Do not send project content or prompts to external services without explicit user approval.
- Do not add branding, homepage links, marketplace links, community links, or runtime dependencies to unrelated upstream projects.
- Preserve the legally required MIT copyright and license notice in `LICENSE`.

## Pull requests

Use `main` as the default base unless the user specifies another branch.

A PR description must state:

- what changed;
- why it changed;
- verification performed;
- known limitations;
- whether any circuit breaker was triggered.

Do not invent test results, performance claims, or compatibility claims.
