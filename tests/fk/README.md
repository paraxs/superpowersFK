# FK Validation

Run:

```bash
bash tests/fk/test-policy.sh
bash tests/fk/test-sdd-workspace.sh
bash tests/fk/test-codex-install.sh
```

These checks protect the Codex Workflow FK contract:

- proportional risk tiers and circuit breakers remain present;
- case-insensitive path collisions are rejected;
- every skill has valid frontmatter and remains below 500 lines;
- the concise `writing-skills` limit remains enforced;
- plugin metadata points only to the FK repository and omits hook discovery;
- upstream namespaces, branding, and harness language do not return to active surfaces;
- the SDD workspace remains isolated and self-ignoring;
- the complete plugin installs with a real Codex CLI.

After a release reaches `main`, also run:

```bash
bash tests/fk/test-remote-main-install.sh
```

Static checks and installation tests do not replace real Codex acceptance sessions. Record representative Tier 1, Tier 2, Tier 3, and circuit-breaker behavior separately.
