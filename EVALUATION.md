# Codex Workflow FK Evaluation

Evaluation target: plugin 1.0.1 on `main`

Scale: 1–10. A score of 9 means the category has explicit controls, practical defaults, regression protection, and verification appropriate to the claim. Scores below are self-assessment based on repository evidence, isolated and remote installation tests, and the recorded Tier 1/2/3 and circuit-breaker sessions. They are not an independent benchmark.

| Category | Score | Evidence |
|---|---:|---|
| Methodological quality | 9.3 | Four risk tiers, root-cause routing, explicit escalation, preservation rules, and four passing controlled routing sessions |
| Quality assurance | 9.5 | Risk-based TDD, fresh verification, full-diff inspection, policy CI, isolated install CI, and remote-main install CI |
| Codex integration | 9.4 | Native manifest, FK marketplace, installed 1.0.1 profile, and real local plus remote installation with Codex CLI |
| Efficiency | 9.3 | Tier 1 skips ceremony; corrected Tier 2 selects a short outline; SDD remains gated |
| Existing-code protection | 9.6 | Global preservation rules, no unrelated refactoring, targeted edits, compatibility checks |
| Multi-agent safety | 9.3 | 8-file and 300-line task limits, two-cycle maximum, compaction and same-failure breakers |
| Cost and context control | 9.0 | File handoffs, no assumed model selection, bounded reviews, stop on disproportionate work |
| Privacy and independence | 9.3 | No active upstream branding or telemetry links in installed Codex surfaces; FK-owned metadata and marketplace |
| Maintainability | 9.3 | Smaller core skills, Codex-only package, contradiction regression checks, and cross-platform installation tests |
| Transparency | 9.6 | Initial Tier 2 failure, corrective PR, exact final prompts/responses, commands, results, and residual limits are recorded |

## Verification completed

- `tests/fk/test-policy.sh` passes in GitHub Actions.
- `tests/fk/test-codex-install.sh` installs Codex CLI 0.144.6 in an isolated temporary environment.
- Codex accepts the FK marketplace and plugin manifest.
- The plugin is installed and reported as enabled.
- The cached manifest matches the source manifest.
- The complete skills tree and critical workflow skills are present after installation.
- No active Codex surface contains the blocked upstream branding and link patterns checked by policy CI.
- Installation from the GitHub `main` marketplace passes on Codex CLI 0.144.6.
- Installed plugin 1.0.1 passes the recorded Tier 1, Tier 2, Tier 3, and circuit-breaker sessions.

## Remaining conditions for a 10

- Repeat routing runs across more prompt formulations and supported models.
- Run end-to-end implementation sessions against representative repositories.
- Verify the plugin in Codex App in addition to Codex CLI.
- Confirm child-agent lifecycle and per-agent model/profile behavior against the active runtime schema.
- Move the finished code into a standalone non-fork repository if complete GitHub-level independence is required.

## Non-negotiable license note

The MIT copyright and permission notice in `LICENSE` must remain in copies or substantial portions. Independence is implemented through branding, metadata, documentation, runtime behavior, and repository ownership—not by removing legally required attribution.
