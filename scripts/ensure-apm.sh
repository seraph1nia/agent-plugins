#!/usr/bin/env bash
set -euo pipefail

export PATH="${HOME}/.local/bin:${PATH}"

if ! command -v apm >/dev/null 2>&1; then
  echo "error: apm is unavailable; run 'mise trust .mise.toml', 'mise install', then 'mise exec -- scripts/validate.sh'" >&2
  exit 1
fi

if ! apm --version | grep -q 'version 0\.18\.0$'; then
  echo "error: expected apm-cli 0.18.0 from .mise.toml; run 'mise install' and retry with 'mise exec -- scripts/validate.sh'" >&2
  exit 1
fi
