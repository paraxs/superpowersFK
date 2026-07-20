# Codex Workflow FK

A pragmatic, preservation-first skill set for OpenAI Codex.

The project is designed for real repositories where working behavior must survive agent-driven changes. It uses proportional planning, root-cause debugging, risk-based testing, isolated workspaces, evidence-based completion, and bounded multi-agent execution.

## Core principles

- Preserve working behavior, UI, exports, interfaces, and compatibility by default.
- Use the smallest reliable workflow for the actual risk.
- Do not repeat questions already answered by the request or repository.
- Investigate root cause before changing code.
- Use automated tests where they provide real protection.
- Do not force artificial tests for copy, CSS, or static configuration changes.
- Keep changes focused, reversible, and independently verifiable.
- Stop and re-plan instead of allowing repeated repair loops to grow without limit.
- Never claim completion without fresh verification evidence.

## Risk tiers

### Tier 0 — inspection

Read, explain, review, or compare. No automatic plans, worktrees, tests, commits, or subagents.

### Tier 1 — focused change

Clear requirements, local scope, normally no more than three closely related files. Inspect, reproduce, make the smallest coherent change, run targeted verification, and inspect the diff.

### Tier 2 — structured change

Several coordinated files or changes to business logic, persistence, APIs, retrieval, permissions, deployment, or rollback behavior. Use an implementation outline, isolation where useful, risk-based TDD, and broader regression checks.

### Tier 3 — architectural or high-risk change

Multiple subsystems, unresolved architecture, security, concurrency, destructive migration, backup/restore, billing, or production data. Use explicit design, a durable plan, isolated execution, bounded tasks, final review, and hard circuit breakers.

## Included skills

- `using-superpowers` — proportional workflow router and global preservation rules
- `brainstorming` — explicit design work only when decisions are genuinely unresolved
- `writing-plans` — durable plans for complex multi-step work
- `systematic-debugging` — evidence and root cause before fixes
- `test-driven-development` — risk-based red-green-refactor
- `using-git-worktrees` — safe isolated workspaces
- `subagent-driven-development` — bounded multi-agent implementation with circuit breakers
- `requesting-code-review` — independent review
- `verification-before-completion` — evidence before completion claims
- `finishing-a-development-branch` — safe branch and PR handoff

## Codex installation

This repository is intended to be installed as a custom Codex plugin or used as a source for personal/project skills.

Repository:

```text
https://github.com/paraxs/superpowersFK
```

For Codex CLI multi-agent workflows, enable the feature in `~/.codex/config.toml`:

```toml
[features]
multi_agent = true
```

Multi-agent execution is optional. The default workflow remains single-agent unless the task passes the SDD entry gate.

## Subagent circuit breakers

A task stops and returns for re-planning when any of these occur:

- more than two repair or re-review cycles;
- the same failure class appears twice;
- one task grows beyond eight changed files;
- the brief exceeds 300 lines;
- the child context is compacted;
- architecture, security, migration, or shared-state boundaries expand beyond the approved plan;
- elapsed work becomes disproportionate to the task size.

A circuit breaker is a stop condition, not permission to dispatch another agent.

## Repository instructions

Project-level `AGENTS.md` files and direct user instructions take precedence over skill defaults. This makes the workflow adaptable to each repository without editing the plugin.

## Verification standard

A completion report must include:

- changed files;
- commands run;
- observed results and exit status;
- targeted and broader tests where applicable;
- diff inspection;
- remaining risks or unverified behavior.

## Privacy

This variant does not require external telemetry or external visual companion services. Keep project content, prompts, and repository data inside the selected Codex environment and configured development services.

## License

MIT License. See `LICENSE` for the legally required copyright and license notice.
