#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

README="README.md"
EXPECTED_FIRST_LINE="Tracing threads at dawn, breadcrumbs bloom through the debug fog."

if [[ ! -f "$README" ]]; then
  echo "error: missing $README" >&2
  exit 1
fi

first_non_empty_line="$(
  awk 'NF { print; exit }' "$README"
)"

if [[ "$first_non_empty_line" != "$EXPECTED_FIRST_LINE" ]]; then
  echo "error: first non-empty line in $README must be the tracing haiku" >&2
  echo "expected: $EXPECTED_FIRST_LINE" >&2
  echo "actual:   ${first_non_empty_line:-<empty>}" >&2
  exit 1
fi
