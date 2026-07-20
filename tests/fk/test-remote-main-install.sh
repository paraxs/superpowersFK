#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
CODEX_VERSION="${CODEX_VERSION:-0.144.6}"
REMOTE_REPOSITORY="${REMOTE_REPOSITORY:-paraxs/superpowersFK}"
PLUGIN_VERSION="$(node -e 'const fs=require("fs"); console.log(JSON.parse(fs.readFileSync(process.argv[1], "utf8")).version)' "$ROOT/.codex-plugin/plugin.json")"
WORK="$(mktemp -d "${TMPDIR:-/tmp}/codex-fk-remote-main.XXXXXX")"
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
node - "$WORK/plugin-add.json" "$PLUGIN_VERSION" <<'JS'
const fs = require("fs");
const data = JSON.parse(fs.readFileSync(process.argv[2], "utf8"));
const expectedVersion = process.argv[3];

if (data.pluginId !== "codex-workflow-fk@codex-workflow-fk") throw new Error("unexpected plugin id");
if (data.name !== "codex-workflow-fk") throw new Error("unexpected plugin name");
if (data.marketplaceName !== "codex-workflow-fk") throw new Error("unexpected marketplace name");
if (data.version !== expectedVersion) throw new Error("unexpected plugin version");
console.log("PASS: Codex installed the FK plugin from the remote main marketplace");
JS

"$CODEX" plugin list > "$WORK/list-after.txt"
grep -Fq "codex-workflow-fk@codex-workflow-fk" "$WORK/list-after.txt"
grep -Fq "installed, enabled" "$WORK/list-after.txt"

CACHE="$CODEX_HOME/plugins/cache/codex-workflow-fk/codex-workflow-fk/$PLUGIN_VERSION"
test -f "$CACHE/.codex-plugin/plugin.json"
test -f "$CACHE/skills/using-codex-workflow/SKILL.md"

echo "PASS: remote main install is enabled with the FK router present"
