---
name: using-git-worktrees
description: Create or reuse an isolated Git workspace without disturbing the current checkout. Use when a substantial change benefits from isolation and the host has not already provided an isolated worktree.
---

# Using Git Worktrees

## Purpose

Use isolation when it protects existing work. Detect host-managed isolation first and avoid repository mutations that are unrelated to the requested change.

## 1. Detect the environment

Run:

```bash
git rev-parse --show-toplevel
git rev-parse --git-dir
git rev-parse --git-common-dir
git branch --show-current
git status --short --branch
```

If `git-dir` differs from `git-common-dir`, confirm the checkout is not a submodule. A linked or host-managed worktree is already isolated; do not create another one.

If the workspace is detached and host-managed, preserve that state until the finishing workflow attaches commits to a branch.

## 2. Decide whether isolation is justified

Use a separate worktree for Tier 2 or Tier 3 changes when:

- the current checkout contains unrelated user changes;
- the work spans several coordinated files;
- rollback or parallel comparison matters;
- the user requests isolation.

For a focused Tier 1 change in a clean checkout, work in place unless repository instructions require otherwise.

## 3. Prefer native isolation

Use the host's worktree or workspace mechanism when available. Native tools own placement, branch creation, and cleanup.

Use manual `git worktree` only when:

- the user has authorized an isolated workspace;
- the host has no native mechanism;
- the target path and branch are explicit.

## 4. Manual fallback

Prefer an existing ignored `.worktrees/` or `worktrees/` directory. Verify it:

```bash
git check-ignore -q .worktrees || git check-ignore -q worktrees
```

If neither path is ignored, do not edit or commit `.gitignore` automatically. Use a safe location outside the repository or ask for the smallest required decision.

Create the worktree with an explicit branch:

```bash
git worktree add "<absolute-path>" -b "<branch-name>"
```

Never create a nested worktree or reuse an existing branch path blindly.

## 5. Prepare without hidden mutations

- Read repository setup instructions before running commands.
- Prefer locked or immutable dependency commands when the project supports them.
- Do not run package installation merely because a manifest exists.
- Do not change lockfiles, dependencies, or generated files unless the task requires it.
- Inspect `git status` before and after setup.
- If setup would change tracked files outside scope, stop and report the evidence.

Examples of repository-defined immutable commands include `npm ci`, `pnpm install --frozen-lockfile`, or equivalent project scripts. Use only the command documented for the repository.

## 6. Verify the baseline

Run the narrowest relevant baseline tests. Broaden only when risk warrants it.

If baseline checks fail:

- record the exact command and failure;
- determine whether it predates the requested change;
- ask before proceeding only when the failure materially affects safe implementation.

## Cleanup ownership

Remove only a worktree created by this workflow and only after the selected finishing action makes removal safe. Never remove a host-managed or user-created workspace.

## Report

Report the absolute worktree path, branch or detached state, baseline command and result, setup actions, and any remaining environmental risk.
