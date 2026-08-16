---
name: package-validation
description: Use when checking a mat-pocok package for manifest, skill-tree, or marketplace drift before shipping.
---

# Package Validation

Use this skill to verify that a `mat-pocok` package still matches the repo's packaging and marketplace conventions.

## Workflow

1. Check the package manifest and skill tree for the expected files.
2. Run the repo validation entrypoint when the APM CLI is available.
3. Inspect generated marketplace output for drift before handing off work.
4. Fix the smallest failing file first, then rerun the same check.

## Useful checks

```sh
test -f plugins/mat-pocok/apm.yml
find plugins/mat-pocok/.apm/skills -name SKILL.md
```

## Guardrails

- Validate the package source before touching generated artifacts.
- Keep any temporary probes outside the package tree.
- Treat validation failures as package issues, not output issues, until proven otherwise.

