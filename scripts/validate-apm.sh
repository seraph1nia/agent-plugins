#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

export PATH="${HOME}/.local/bin:${PATH}"

if ! command -v apm >/dev/null 2>&1; then
  if ! command -v python >/dev/null 2>&1; then
    echo "error: apm is not installed and python is unavailable; run 'mise install' first" >&2
    exit 1
  fi

  python -m pip install --upgrade --user apm-cli
fi

if ! command -v apm >/dev/null 2>&1; then
  echo "error: apm-cli installation completed but 'apm' is still not on PATH" >&2
  exit 1
fi

apm pack --check-clean --json
