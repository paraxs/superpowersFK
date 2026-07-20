#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

python3 - "$ROOT" <<'PY'
import json
import pathlib
import re
import subprocess
import sys

root = pathlib.Path(sys.argv[1])
errors: list[str] = []

def fail(message: str) -> None:
    errors.append(message)

def read(relative: str) -> str:
    return (root / relative).read_text(encoding="utf-8")

tracked = subprocess.check_output(
    ["git", "-C", str(root), "ls-files"], text=True, encoding="utf-8"
).splitlines()

case_map: dict[str, list[str]] = {}
for path in tracked:
    case_map.setdefault(path.casefold(), []).append(path)
for paths in case_map.values():
    if len(paths) > 1:
        fail("case-insensitive path collision: " + " | ".join(paths))

skill_files = sorted((root / "skills").glob("*/SKILL.md"))
if len(skill_files) != 14:
    fail(f"expected 14 skills, found {len(skill_files)}")

for path in skill_files:
    text = path.read_text(encoding="utf-8")
    relative = path.relative_to(root).as_posix()
    lines = text.splitlines()
    if len(lines) > 500:
        fail(f"{relative} exceeds 500 lines: {len(lines)}")
    match = re.match(
        r"^---\nname: ([a-z0-9-]+)\ndescription: (.+?)\n---\n",
        text,
        flags=re.DOTALL,
    )
    if not match:
        fail(f"{relative} has invalid frontmatter")
        continue
    name, description = match.groups()
    if name != path.parent.name:
        fail(f"{relative} name does not match folder: {name}")
    if "Use when" not in description:
        fail(f"{relative} description lacks a concrete 'Use when' trigger")

writing_lines = len(read("skills/writing-skills/SKILL.md").splitlines())
if writing_lines > 180:
    fail(f"writing-skills must stay concise (<=180 lines), found {writing_lines}")

active_paths = [
    root / ".codex-plugin",
    root / ".agents" / "plugins",
    root / "skills",
    root / "README.md",
    root / "AGENTS.md",
    root / "package.json",
]
active_files: list[pathlib.Path] = []
for path in active_paths:
    if path.is_dir():
        active_files.extend(p for p in path.rglob("*") if p.is_file())
    elif path.is_file():
        active_files.append(path)

for path in active_files:
    try:
        text = path.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        continue
    relative = path.relative_to(root).as_posix()
    for forbidden in (
        "superpowers:",
        "your human partner",
        "Superpowers works",
        ".superpowers/",
        "Anthropic",
        "Claude Code",
        "github.com/obra",
        "Jesse Vincent",
        "primeradiant",
        "fsck.com",
    ):
        if forbidden.casefold() in text.casefold():
            fail(f"{relative} contains forbidden active-surface text: {forbidden}")

if (root / "skills" / "using-superpowers").exists():
    fail("legacy skills/using-superpowers directory still exists")

required = {
    "skills/using-codex-workflow/SKILL.md": (
        "Tier 0",
        "Tier 1",
        "Tier 2",
        "Tier 3",
        "more than two repair/re-review cycles",
    ),
    "skills/executing-plans/SKILL.md": (
        "Subagent availability alone is not a reason to delegate",
    ),
    "skills/requesting-code-review/SKILL.md": (
        "Do not create review ceremony for a focused Tier 1 change",
    ),
    "skills/using-git-worktrees/SKILL.md": (
        "do not edit or commit `.gitignore` automatically",
        "Do not run package installation merely because a manifest exists",
    ),
    "skills/writing-skills/SKILL.md": (
        "Increase evaluation depth with behavioral risk",
        "no installation, commit, push, or external-service action occurs without user intent",
    ),
    "skills/writing-plans/SKILL.md": (
        "Do not invoke solely because a Tier 2 change spans several files",
        "short inline outline when requirements, interfaces, and execution order are already settled",
    ),
}
for relative, snippets in required.items():
    text = read(relative)
    for snippet in snippets:
        if snippet not in text:
            fail(f"{relative} missing required policy: {snippet}")

for relative, forbidden in {
    "skills/executing-plans/SKILL.md": (
        "If subagents are available",
        "superpowers:",
    ),
    "skills/requesting-code-review/SKILL.md": (
        'Skip review because "it\'s simple"',
    ),
    "skills/using-git-worktrees/SKILL.md": (
        "Add to .gitignore, commit the change",
        "if [ -f package.json ]; then npm install",
    ),
    "skills/writing-skills/SKILL.md": (
        "Delete it. Start over",
        "push to your fork",
        "NO SKILL WITHOUT A FAILING TEST FIRST",
    ),
}.items():
    text = read(relative)
    for snippet in forbidden:
        if snippet in text:
            fail(f"{relative} contains contradictory policy: {snippet}")

manifest = json.loads(read(".codex-plugin/plugin.json"))
if manifest.get("name") != "codex-workflow-fk":
    fail("plugin manifest name must be codex-workflow-fk")
package = json.loads(read("package.json"))
if manifest.get("version") != package.get("version"):
    fail("plugin manifest and package versions must match")
if manifest.get("repository") != "https://github.com/paraxs/superpowersFK":
    fail("plugin manifest repository is not FK-owned")
if "hooks" in manifest:
    fail("plugin manifest must omit unsupported hooks metadata")

marketplace = json.loads(read(".agents/plugins/marketplace.json"))
if marketplace.get("name") != "codex-workflow-fk":
    fail("marketplace name must be codex-workflow-fk")
plugins = marketplace.get("plugins", [])
if len(plugins) != 1:
    fail("marketplace must contain exactly one plugin")
else:
    entry = plugins[0]
    if entry.get("name") != "codex-workflow-fk":
        fail("marketplace plugin name mismatch")
    source = entry.get("source", {})
    if source.get("url") != "https://github.com/paraxs/superpowersFK.git":
        fail("marketplace source URL mismatch")
    if source.get("ref") != "main":
        fail("marketplace source must target main")

if errors:
    for error in errors:
        print(f"FAIL: {error}", file=sys.stderr)
    raise SystemExit(f"{len(errors)} policy test(s) failed")

print(f"PASS: FK policy, namespace, manifest, and {len(skill_files)} skills are consistent")
PY
