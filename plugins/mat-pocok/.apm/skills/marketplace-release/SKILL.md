---
name: marketplace-release
description: Use when updating the root marketplace manifest and committed Claude marketplace output for mat-pocok.
---

# Marketplace Release

Use this skill when the `mat-pocok` package needs to be registered in the root marketplace manifest and reflected in generated marketplace output.

## Workflow

1. Add or update the package entry in root `apm.yml`.
2. Mirror the change in `.claude-plugin/marketplace.json`.
3. Keep the package name, source path, description, tags, and repository metadata in sync.
4. Validate the generated marketplace artifact before committing.

## Guardrails

- Append new packages in marketplace order unless a deliberate reordering is requested.
- Do not change generated output without changing the source manifest.
- Keep the package source path relative to the repo root.

