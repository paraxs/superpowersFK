# Codex Workflow FK Evaluation

Evaluation target: branch `agent/codex-pragmatic-fk`

Scale: 1–10. A score of 9 means the category has explicit controls, practical defaults, regression protection, and verification appropriate to the claim. Scores below are based on repository evidence plus a real Codex CLI installation test. Model-level routing behavior still requires recorded acceptance sessions before a 10 can be justified.

| Category | Score | Evidence |
|---|---:|---|
| Methodological quality | 9.3 | Four risk tiers, root-cause routing, explicit escalation and preservation rules |
| Quality assurance | 9.5 | Risk-based TDD, fresh verification, full-diff inspection requirements, policy CI, and installation CI |
| Codex integration | 9.3 | Native manifest without hook discovery surfaces, FK marketplace, real installation and enablement with Codex CLI 0.144.6 |
| Efficiency | 9.2 | No universal brainstorming gate, short outlines for Tier 2, SDD only after entry gate |
| Existing-code protection | 9.6 | Global preservation rules, no unrelated refactoring, targeted edits, compatibility checks |
| Multi-agent safety | 9.3 | 8-file and 300-line task limits, two-cycle maximum, compaction and same-failure breakers |
| Cost and context control | 9.0 | File handoffs, no assumed model selection, bounded reviews, stop on disproportionate work |
| Privacy and independence | 9.3 | No active upstream branding or telemetry links in installed Codex surfaces; FK-owned metadata and marketplace |
| Maintainability | 9.2 | Smaller core skills, Codex-only package metadata, repository policy, regression and installation tests |
| Transparency | 9.5 | Mandatory commands, observed results, remaining risks, and explicit non-verification reporting |

## Verification completed

- `tests/fk/test-policy.sh` passes in GitHub Actions.
- `tests/fk/test-codex-install.sh` installs Codex CLI 0.144.6 in an isolated temporary environment.
- Codex accepts the FK marketplace and plugin manifest.
- The plugin is installed and reported as enabled.
- The cached manifest matches the source manifest.
- The complete skills tree and critical workflow skills are present after installation.
- No active Codex surface contains the blocked upstream branding and link patterns checked by policy CI.

## Remaining conditions for a 10

- Run controlled, authenticated Codex acceptance sessions for Tier 1, Tier 2, Tier 3, and circuit-breaker behavior.
- Verify automatic routing behavior with real model responses, not only installation and discovery artifacts.
- Verify the plugin in Codex App in addition to Codex CLI.
- Confirm child-agent lifecycle and per-agent model/profile behavior against the active runtime schema.
- Move the finished code into a standalone non-fork repository if complete GitHub-level independence is required.

## Non-negotiable license note

The MIT copyright and permission notice in `LICENSE` must remain in copies or substantial portions. Independence is implemented through branding, metadata, documentation, runtime behavior, and repository ownership—not by removing legally required attribution.
