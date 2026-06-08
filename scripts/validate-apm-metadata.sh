#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

. "$ROOT_DIR/scripts/ensure-apm.sh"

if ! MARKETPLACE_CHECK_OUTPUT="$(apm marketplace check --offline 2>&1)"; then
  printf '%s\n' "$MARKETPLACE_CHECK_OUTPUT"

  if grep -q 'source: ./plugins/' apm.yml && grep -q 'No cached refs' <<<"$MARKETPLACE_CHECK_OUTPUT"; then
    echo "warning: apm marketplace check --offline has no cached refs for local package sources; continuing with apm pack validation" >&2
  else
    exit 1
  fi
else
  printf '%s\n' "$MARKETPLACE_CHECK_OUTPUT"
fi

PACK_OUTPUT="$(apm pack --check-clean --json)"
printf '%s\n' "$PACK_OUTPUT"

PACK_OUTPUT="$PACK_OUTPUT" node <<'NODE'
const report = JSON.parse(process.env.PACK_OUTPUT);
const errors = [];

if (report.ok !== true) {
  errors.push('apm pack report did not return ok=true');
}

const outputs = report.marketplace && Array.isArray(report.marketplace.outputs)
  ? report.marketplace.outputs
  : [];

const claudeOutput = outputs.find((output) => output.path && output.path.endsWith('/.claude-plugin/marketplace.json'));
if (!claudeOutput) {
  errors.push('apm pack did not validate .claude-plugin/marketplace.json');
}

if (!report.drift || report.drift.ok !== true) {
  errors.push('apm pack drift report did not return ok=true');
}

const driftOutputs = report.drift && Array.isArray(report.drift.outputs)
  ? report.drift.outputs
  : [];
const claudeDrift = driftOutputs.find((output) => output.path === '.claude-plugin/marketplace.json');
if (!claudeDrift || claudeDrift.status !== 'unchanged') {
  errors.push('generated Claude marketplace metadata is not clean');
}

if (errors.length > 0) {
  console.error(errors.map((error) => `error: ${error}`).join('\n'));
  process.exit(1);
}
NODE
