---
name: plugin-scaffold
description: Use when creating or updating a mat-pocok plugin package skeleton. Keep the package minimal, valid, and normalized to lower-case hyphen-case.
---

# Plugin Scaffold

Use this skill when you need to create a new `mat-pocok` package or extend its basic package layout without adding speculative files.

## Workflow

1. Normalize the package name to lower-case hyphen-case.
2. Create the package root under `plugins/<name>/`.
3. Add a valid `apm.yml` with the package identity, author, license, and supported targets.
4. Create `.apm/skills/` and place each skill in its own directory with a `SKILL.md` file.
5. Keep the skeleton lean until a follow-up task introduces a concrete primitive.

## Guardrails

- Do not add placeholder files that are not part of the package layout.
- Do not add extra skills just to fill the tree.
- Keep the package name, directory name, and manifest `name` field identical after normalization.

## Quick check

```sh
test -f plugins/mat-pocok/apm.yml
find plugins/mat-pocok/.apm/skills -mindepth 2 -maxdepth 2 -name SKILL.md
```
