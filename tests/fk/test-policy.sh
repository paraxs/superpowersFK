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
require_text "skills/subagent-driven-development/SKILL.md" "maximum 8"
require_text "skills/subagent-driven-development/SKILL.md" "300 lines"
require_text "skills/subagent-driven-development/SKILL.md" "stop and re-plan"
require_text "skills/using-superpowers/references/codex-tools.md" "inherits the parent configuration"
require_text "AGENTS.md" "Preserve working behavior"
require_text "README.md" "Codex Workflow FK"
require_text ".codex-plugin/plugin.json" '"name": "codex-workflow-fk"'
require_text ".codex-plugin/plugin.json" '"hooks": {}'

forbid_text "skills/using-superpowers/SKILL.md" "even a 1% chance"
forbid_text "skills/brainstorming/SKILL.md" "This applies to EVERY project"
forbid_text "skills/test-driven-development/SKILL.md" "Delete code. Start over"
forbid_text "README.md" "github.com/obra"
forbid_text "README.md" "primeradiant"
forbid_text ".codex-plugin/plugin.json" "github.com/obra"
forbid_text ".codex-plugin/plugin.json" "Jesse Vincent"

python3 - <<'PY' "$ROOT/.codex-plugin/plugin.json" || failures=$((failures + 1))
import json, sys
path = sys.argv[1]
with open(path, encoding="utf-8") as f:
    data = json.load(f)
assert data["name"] == "codex-workflow-fk"
assert data["version"] == "1.0.0"
assert data["hooks"] == {}
assert data["repository"] == "https://github.com/paraxs/superpowersFK"
print("PASS: plugin manifest is valid JSON and independent metadata is set")
PY

if (( failures > 0 )); then
  echo "$failures policy test(s) failed" >&2
  exit 1
fi

echo "PASS: Codex Workflow FK policy checks"
