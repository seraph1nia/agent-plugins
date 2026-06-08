#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

MARKETPLACE_JSON=".claude-plugin/marketplace.json"

if [[ ! -f "$MARKETPLACE_JSON" ]]; then
  echo "error: missing $MARKETPLACE_JSON" >&2
  exit 1
fi

if ! command -v node >/dev/null 2>&1; then
  echo "error: node is required for Claude marketplace JSON validation; run 'mise install' first" >&2
  exit 1
fi

node <<'NODE'
const fs = require('node:fs');

const file = '.claude-plugin/marketplace.json';
const marketplace = JSON.parse(fs.readFileSync(file, 'utf8'));
const errors = [];

const isObject = (value) => value !== null && typeof value === 'object' && !Array.isArray(value);
const requireString = (object, path) => {
  const value = path.split('.').reduce((current, key) => current && current[key], object);
  if (typeof value !== 'string' || value.trim() === '') {
    errors.push(`${path} must be a non-empty string`);
  }
};

if (!isObject(marketplace)) {
  errors.push('marketplace root must be an object');
} else {
  requireString(marketplace, 'name');
  requireString(marketplace, 'owner.name');
  requireString(marketplace, 'metadata.homepage');
  requireString(marketplace, 'metadata.pluginRoot');

  if (!Array.isArray(marketplace.plugins) || marketplace.plugins.length === 0) {
    errors.push('plugins must be a non-empty array');
  } else {
    const names = new Set();

    marketplace.plugins.forEach((plugin, index) => {
      const prefix = `plugins[${index}]`;
      if (!isObject(plugin)) {
        errors.push(`${prefix} must be an object`);
        return;
      }

      ['name', 'description', 'license', 'homepage', 'repository', 'source'].forEach((field) => {
        if (typeof plugin[field] !== 'string' || plugin[field].trim() === '') {
          errors.push(`${prefix}.${field} must be a non-empty string`);
        }
      });

      if (!isObject(plugin.author) || typeof plugin.author.name !== 'string' || plugin.author.name.trim() === '') {
        errors.push(`${prefix}.author.name must be a non-empty string`);
      }

      if (!Array.isArray(plugin.tags) || plugin.tags.some((tag) => typeof tag !== 'string' || tag.trim() === '')) {
        errors.push(`${prefix}.tags must be an array of non-empty strings`);
      }

      if (typeof plugin.name === 'string') {
        if (names.has(plugin.name)) {
          errors.push(`${prefix}.name duplicates another plugin name`);
        }
        names.add(plugin.name);
      }
    });
  }
}

if (errors.length > 0) {
  console.error(errors.map((error) => `error: ${error}`).join('\n'));
  process.exit(1);
}
NODE
