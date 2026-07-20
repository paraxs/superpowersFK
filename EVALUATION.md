# Codex Workflow FK Evaluation

Evaluation target: branch `agent/codex-pragmatic-fk`

Scale: 1–10. A score of 9 means the category has explicit controls, practical defaults, and regression protection. Scores are based on repository evidence; runtime behavior still requires a real Codex acceptance session before a 10 can be justified.

| Category | Score | Evidence |
|---|---:|---|
| Methodological quality | 9.3 | Four risk tiers, root-cause routing, explicit escalation and preservation rules |
| Quality assurance | 9.4 | Risk-based TDD, fresh verification requirement, diff inspection, policy CI |
| Codex integration | 9.1 | Codex manifest, empty hooks object, worktree guidance, multi-agent capability checks |
| Efficiency | 9.2 | No universal brainstorming gate, short outlines for Tier 2, SDD only after entry gate |
| Existing-code protection | 9.6 | Global preservation rules, no unrelated refactoring, targeted edits, compatibility checks |
| Multi-agent safety | 9.3 | 8-file and 300-line task limits, two-cycle maximum, compaction and same-failure breakers |
| Cost and context control | 9.0 | File handoffs, no assumed model selection, bounded reviews, stop on disproportionate work |
| Privacy and independence | 9.1 | No default telemetry, fork-owned metadata and links, no external helper services by default |
| Maintainability | 9.0 | Smaller core skills, repository policy, CI assertions against regressions |
| Transparency | 9.5 | Mandatory commands, results, remaining risks, and explicit non-verification reporting |

## Remaining conditions for a 10

- Run controlled Codex acceptance sessions for Tier 1, Tier 2, Tier 3, and circuit-breaker behavior.
- Package and install the plugin from the fork, then verify skill discovery in both Codex App and Codex CLI.
- Confirm current Codex child-agent lifecycle and per-agent model/profile behavior against the actual runtime schema.
- Move the finished code into a standalone non-fork repository if complete GitHub-level independence is required.

## Non-negotiable license note

The MIT copyright and permission notice in `LICENSE` must remain in copies or substantial portions. Independence is implemented through branding, metadata, documentation, runtime behavior, and repository ownership—not by removing legally required attribution.
