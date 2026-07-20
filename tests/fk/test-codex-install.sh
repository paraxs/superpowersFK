#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
CODEX_VERSION="${CODEX_VERSION:-0.144.6}"
PLUGIN_VERSION="$(node -e 'const fs=require("fs"); console.log(JSON.parse(fs.readFileSync(process.argv[1], "utf8")).version)' "$ROOT/.codex-plugin/plugin.json")"
WORK="$ROOT/.tmp-codex-install-test-$$"
MARKETPLACE="$WORK/marketplace"
PLUGIN="$MARKETPLACE/plugins/codex-workflow-fk"
CODEX_HOME="$WORK/codex-home"
NPM_PREFIX="$WORK/npm"

cleanup() {
  rm -rf "$WORK"
}
trap cleanup EXIT

mkdir -p "$PLUGIN" "$MARKETPLACE/.agents/plugins" "$CODEX_HOME" "$NPM_PREFIX"
cp -R "$ROOT/.codex-plugin" "$PLUGIN/"
cp -R "$ROOT/skills" "$PLUGIN/"

cat > "$MARKETPLACE/.agents/plugins/marketplace.json" <<'JSON'
{
  "name": "fk-ci",
  "interface": {
    "displayName": "FK CI"
  },
  "plugins": [
    {
      "name": "codex-workflow-fk",
      "source": {
        "source": "local",
        "path": "./plugins/codex-workflow-fk"
      },
      "policy": {
        "installation": "AVAILABLE",
        "authentication": "ON_INSTALL"
      },
      "category": "Developer Tools"
    }
  ]
}
JSON

npm install --silent --no-audit --no-fund --prefix "$NPM_PREFIX" "@openai/codex@$CODEX_VERSION"
CODEX="$NPM_PREFIX/node_modules/.bin/codex"
export CODEX_HOME

version_output="$($CODEX --version)"
echo "Codex runtime: $version_output"
[[ "$version_output" == *"$CODEX_VERSION"* ]]

$CODEX plugin marketplace add "$MARKETPLACE" --json > "$WORK/marketplace-add.json"
$CODEX plugin list > "$WORK/list-before.txt"
grep -Fq "codex-workflow-fk@fk-ci" "$WORK/list-before.txt"
grep -Fq "not installed" "$WORK/list-before.txt"

$CODEX plugin add codex-workflow-fk@fk-ci --json > "$WORK/plugin-add.json"
node - "$WORK/plugin-add.json" "$PLUGIN_VERSION" <<'JS'
const fs = require("fs");
const data = JSON.parse(fs.readFileSync(process.argv[2], "utf8"));
const expectedVersion = process.argv[3];

if (data.pluginId !== "codex-workflow-fk@fk-ci") throw new Error("unexpected plugin id");
if (data.name !== "codex-workflow-fk") throw new Error("unexpected plugin name");
if (data.marketplaceName !== "fk-ci") throw new Error("unexpected marketplace name");
if (data.version !== expectedVersion) throw new Error("unexpected plugin version");
console.log("PASS: Codex accepted and installed the FK plugin manifest");
JS

$CODEX plugin list > "$WORK/list-after.txt"
grep -Fq "codex-workflow-fk@fk-ci" "$WORK/list-after.txt"
grep -Fq "installed, enabled" "$WORK/list-after.txt"

CACHE="$CODEX_HOME/plugins/cache/fk-ci/codex-workflow-fk/$PLUGIN_VERSION"
test -f "$CACHE/.codex-plugin/plugin.json"
cmp "$ROOT/.codex-plugin/plugin.json" "$CACHE/.codex-plugin/plugin.json"

source_skill_count="$(find "$ROOT/skills" -name SKILL.md -type f | wc -l | tr -d ' ')"
installed_skill_count="$(find "$CACHE/skills" -name SKILL.md -type f | wc -l | tr -d ' ')"
[[ "$source_skill_count" -gt 0 ]]
[[ "$installed_skill_count" == "$source_skill_count" ]]

for skill in \
  using-codex-workflow \
  brainstorming \
  systematic-debugging \
  test-driven-development \
  writing-plans \
  subagent-driven-development \
  verification-before-completion; do
  test -f "$CACHE/skills/$skill/SKILL.md"
done

grep -Fq '[plugins."codex-workflow-fk@fk-ci"]' "$CODEX_HOME/config.toml"
grep -Fq 'enabled = true' "$CODEX_HOME/config.toml"

echo "PASS: Codex Workflow FK installed and enabled with $installed_skill_count skills"
