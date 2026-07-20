# Migration to a Standalone Repository

A GitHub fork remains visibly connected to its parent repository in the fork network.

For complete hosting independence:

1. Create a new empty repository that is not a fork.
2. Export the approved FK branch as a new root history or a squashed initial commit.
3. Push that history to the standalone repository.
4. Update the Codex manifest, README, and package metadata to the new repository URL.
5. Retain the MIT copyright and license notice in `LICENSE`.
6. Archive or delete the fork only after the standalone repository is verified.

Do not rewrite or force-push the current fork merely to hide history. That does not remove GitHub's fork-network relationship and creates unnecessary risk.
