#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$ROOT_DIR"

if [[ ! -f "apm.yml" || ! -d "plugins" ]]; then
  echo "error: scripts/validate.sh must run from the agent-plugins repository" >&2
  exit 1
fi

run_step() {
  local name="$1"
  shift

  printf '==> %s\n' "$name"
  "$@"
}

run_step "Validate generated Claude marketplace metadata" bash "$SCRIPT_DIR/validate-claude-marketplace.sh"
run_step "Validate APM marketplace and plugin metadata" bash "$SCRIPT_DIR/validate-apm-metadata.sh"
run_step "Validate APM package output" bash "$SCRIPT_DIR/validate-apm.sh"
