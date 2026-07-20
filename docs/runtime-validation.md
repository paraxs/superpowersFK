# Runtime Validation Status

## Proven

The repository now has two automated GitHub Actions checks:

- policy and independence validation;
- installation with the real Codex CLI 0.144.6.

The installation test proves that Codex:

- accepts the FK marketplace and plugin manifest;
- installs `codex-workflow-fk` into an isolated Codex home;
- reports the plugin as installed and enabled;
- caches the source manifest unchanged;
- includes the complete skills tree and critical workflow skills;
- writes the enabled plugin entry to Codex configuration.

## Still requiring authenticated acceptance sessions

Installation proves packaging and discovery artifacts, not the decisions produced by a model. Recorded Codex sessions are still required for:

- automatic selection of the appropriate skill in a real conversation;
- Tier 1 routing;
- Tier 2 routing;
- Tier 3 planning;
- SDD circuit-breaker behavior;
- child-agent lifecycle;
- per-agent model/profile behavior in the installed Codex version.

Do not claim these model-level runtime behaviors are proven until the corresponding sessions have been executed and recorded.
