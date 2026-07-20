# Codex Runtime Notes

## Multi-agent support

Enable multi-agent tools only when needed:

```toml
[features]
multi_agent = true
```

This can expose `spawn_agent`, `wait_agent`, and `close_agent` depending on the active Codex runtime.

Do not assume that a generic child-agent dispatch can select a different model or reasoning effort. Confirm the actual tool schema or configured Codex agent profile first. When no explicit per-child selection is available, state that the child inherits the parent configuration.

Always close completed implementer and reviewer agents.

## Bounded execution

Before using subagent-driven development, enforce the skill's entry gate:

- at least two independent tasks;
- no more than 8 expected changed files per task;
- no more than 300 lines per task brief;
- clear acceptance criteria and verification;
- no unresolved architecture or destructive production operation.

Stop after two repair/re-review cycles or when the same failure class appears twice.

## Environment detection

Detect an existing linked worktree before creating another:

```bash
GIT_DIR=$(cd "$(git rev-parse --git-dir)" 2>/dev/null && pwd -P)
GIT_COMMON=$(cd "$(git rev-parse --git-common-dir)" 2>/dev/null && pwd -P)
BRANCH=$(git branch --show-current)
```

- `GIT_DIR != GIT_COMMON` means the workspace is already linked or externally managed.
- An empty `BRANCH` means detached HEAD.
- Do not remove a worktree owned by the Codex host.

## Codex App finishing

In an externally managed detached worktree, Codex may be able to test, stage, and commit but not create branches, push, or open pull requests from the sandbox.

When blocked:

- preserve the commits;
- report the full commit SHA;
- provide a safe suggested branch name and commit message;
- use the host's native branch, handoff, push, or PR controls;
- warn that detached commits must be attached to a branch before workspace cleanup.

## Repository instructions

Read the nearest applicable `AGENTS.md` before changing code. Direct user instructions and repository rules override skill defaults.

## Privacy

Do not start external visual companions, telemetry, or remote helper services unless the user explicitly requests them and understands what leaves the local environment.
