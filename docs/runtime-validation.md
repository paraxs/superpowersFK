# Runtime Validation Status

## Proven

The repository now has three automated GitHub Actions checks:

- policy and independence validation;
- isolated installation with the real Codex CLI 0.144.6;
- remote marketplace installation from GitHub `main` after merge.

The installation test proves that Codex:

- accepts the FK marketplace and plugin manifest;
- installs `codex-workflow-fk` into an isolated Codex home;
- reports the plugin as installed and enabled;
- caches the source manifest unchanged;
- includes the complete skills tree and critical workflow skills;
- writes the enabled plugin entry to Codex configuration.

The remote test additionally proves that Codex can register `paraxs/superpowersFK --ref main`, install the published marketplace plugin, and discover the FK router from the cached package.

Four authenticated fresh-process sessions using installed plugin 1.0.1 and GPT-5.5 passed the Tier 1, Tier 2, Tier 3, and circuit-breaker scenarios. The Tier 2 run initially found a plan-routing contradiction in 1.0.0; version 1.0.1 corrected it and the repeated run passed. See [the recorded run](acceptance-runs/2026-07-20.md).

## Still requiring runtime acceptance

The current evidence is one controlled run per routing scenario. Additional evidence is still required for:

- repeated routing runs across different prompt formulations and models;
- end-to-end implementation sessions that edit and verify real code;
- child-agent lifecycle;
- per-agent model/profile behavior in the installed Codex version.
- Codex App behavior separately from CLI behavior.

Do not generalize the controlled routing results beyond the recorded runtime and scenario shapes.
