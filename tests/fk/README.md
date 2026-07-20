# FK Policy Tests

Run:

```bash
bash tests/fk/test-policy.sh
```

The checks protect the behavioral contract of Codex Workflow FK:

- proportional risk tiers remain present;
- universal brainstorming and absolute TDD wording stays removed;
- multi-agent task and retry limits remain present;
- Codex model inheritance is disclosed;
- plugin metadata points only to the FK repository;
- upstream branding and runtime links do not return to active documentation or the Codex manifest.

These static checks do not replace real Codex acceptance sessions. They prevent policy regressions that can be detected deterministically in CI.
