#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
CODEX_VERSION="${CODEX_VERSION:-0.144.6}"
REMOTE_REPOSITORY="${REMOTE_REPOSITORY:-paraxs/superpowersFK}"
WORK="$ROOT/.tmp-codex-remote-main-test-$$"
CODEX_HOME="$WORK/codex-home"
NPM_PREFIX="$WORK/npm"

cleanup() {
  rm -rf "$WORK"
}
trap cleanup EXIT

mkdir -p "$CODEX_HOME" "$NPM_PREFIX"
npm install --silent --no-audit --no-fund --prefix "$NPM_PREFIX" "@openai/codex@$CODEX_VERSION"
CODEX="$NPM_PREFIX/node_modules/.bin/codex"
export CODEX_HOME

"$CODEX" plugin marketplace add "$REMOTE_REPOSITORY" --ref main --json > "$WORK/marketplace-add.json"
"$CODEX" plugin list > "$WORK/list-before.txt"
grep -Fq "codex-workflow-fk@codex-workflow-fk" "$WORK/list-before.txt"
grep -Fq "not installed" "$WORK/list-before.txt"

"$CODEX" plugin add codex-workflow-fk@codex-workflow-fk --json > "$WORK/plugin-add.json"
python3 - "$WORK/plugin-add.json" <<'PY'
import json
import sys

with open(sys.argv[1], encoding="utf-8") as f:
    data = json.load(f)

assert data["pluginId"] == "codex-workflow-fk@codex-workflow-fk"
assert data["name"] == "codex-workflow-fk"
assert data["marketplaceName"] == "codex-workflow-fk"
assert data["version"] == "1.0.0"
print("PASS: Codex installed the FK plugin from the remote main marketplace")
PY

"$CODEX" plugin list > "$WORK/list-after.txt"
grep -Fq "codex-workflow-fk@codex-workflow-fk" "$WORK/list-after.txt"
grep -Fq "installed, enabled" "$WORK/list-after.txt"

CACHE="$CODEX_HOME/plugins/cache/codex-workflow-fk/codex-workflow-fk/1.0.0"
test -f "$CACHE/.codex-plugin/plugin.json"
test -f "$CACHE/skills/using-codex-workflow/SKILL.md"

echo "PASS: remote main install is enabled with the FK router present"
