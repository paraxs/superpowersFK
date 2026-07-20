#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
failures=0

fail() {
  echo "FAIL: $*" >&2
  failures=$((failures + 1))
}

require_text() {
  local file="$1"
  local text="$2"
  grep -Fq "$text" "$ROOT/$file" || fail "$file missing required text: $text"
}

forbid_text() {
  local file="$1"
  local text="$2"
  if grep -Fq "$text" "$ROOT/$file"; then
    fail "$file contains forbidden text: $text"
  fi
}

require_text "skills/using-superpowers/SKILL.md" "Tier 0"
require_text "skills/using-superpowers/SKILL.md" "Tier 1"
require_text "skills/using-superpowers/SKILL.md" "Tier 2"
require_text "skills/using-superpowers/SKILL.md" "Tier 3"
require_text "skills/using-superpowers/SKILL.md" "more than two repair/re-review cycles"
require_text "skills/brainstorming/SKILL.md" "Do not use this skill when"
require_text "skills/test-driven-development/SKILL.md" "risk-based"
require_text "skills/subagent-driven-development/SKILL.md" "no more than 8 files"
require_text "skills/subagent-driven-development/SKILL.md" "300 lines"
require_text "skills/subagent-driven-development/SKILL.md" "stop and re-plan"
require_text "skills/using-superpowers/references/codex-tools.md" "inherits the parent configuration"
require_text "AGENTS.md" "Preserve working behavior"
require_text "README.md" "Codex Workflow FK"
require_text "README.md" "codex plugin add codex-workflow-fk@codex-workflow-fk"
require_text ".codex-plugin/plugin.json" '"name": "codex-workflow-fk"'
require_text ".codex-plugin/plugin.json" '"hooks": {}'
require_text ".agents/plugins/marketplace.json" '"name": "codex-workflow-fk"'
require_text ".agents/plugins/marketplace.json" '"url": "https://github.com/paraxs/superpowersFK.git"'

forbid_text "skills/using-superpowers/SKILL.md" "even a 1% chance"
forbid_text "skills/brainstorming/SKILL.md" "This applies to EVERY project"
forbid_text "skills/test-driven-development/SKILL.md" "Delete code. Start over"
forbid_text ".agents/plugins/marketplace.json" '"name": "superpowers"'
forbid_text ".agents/plugins/marketplace.json" '"name": "superpowers-dev"'

ACTIVE_PATHS=(
  "$ROOT/.codex-plugin"
  "$ROOT/.agents/plugins"
  "$ROOT/skills"
  "$ROOT/README.md"
  "$ROOT/AGENTS.md"
  "$ROOT/package.json"
)

for forbidden in "github.com/obra" "Jesse Vincent" "primeradiant" "fsck.com"; do
  if grep -RFIq --exclude-dir=.git "$forbidden" "${ACTIVE_PATHS[@]}"; then
    fail "active Codex surfaces contain forbidden upstream reference: $forbidden"
  fi
done

python3 - "$ROOT/.codex-plugin/plugin.json" "$ROOT/.agents/plugins/marketplace.json" <<'PY' || failures=$((failures + 1))
import json
import sys

manifest_path, marketplace_path = sys.argv[1:]
with open(manifest_path, encoding="utf-8") as f:
    manifest = json.load(f)
with open(marketplace_path, encoding="utf-8") as f:
    marketplace = json.load(f)

assert manifest["name"] == "codex-workflow-fk"
assert manifest["version"] == "1.0.0"
assert manifest["hooks"] == {}
assert manifest["repository"] == "https://github.com/paraxs/superpowersFK"

assert marketplace["name"] == "codex-workflow-fk"
assert marketplace["interface"]["displayName"] == "Codex Workflow FK"
assert len(marketplace["plugins"]) == 1
entry = marketplace["plugins"][0]
assert entry["name"] == "codex-workflow-fk"
assert entry["source"]["source"] == "url"
assert entry["source"]["url"] == "https://github.com/paraxs/superpowersFK.git"
assert entry["source"]["ref"] == "main"
print("PASS: plugin and marketplace metadata are valid and FK-owned")
PY

if (( failures > 0 )); then
  echo "$failures policy test(s) failed" >&2
  exit 1
fi

echo "PASS: Codex Workflow FK policy checks"
