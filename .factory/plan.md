# Implementation Plan

1. Create a new APM package for the requested plugin under `plugins/mat-pocok/` (normalized hyphen-case name) with its own `apm.yml`.
2. Add the plugin’s dev skills as separate primitives under `plugins/mat-pocok/.apm/skills/` using one `SKILL.md` per skill, keeping each skill narrowly scoped and reusable.
3. Register the new package in the marketplace manifest at root `apm.yml`, and update `README.md` so the package list and package details describe the new plugin and its skill set.
4. Regenerate `.claude-plugin/marketplace.json` from the root manifest so the committed Claude marketplace artifact stays in sync.
5. Validate the result with `mise exec -- scripts/validate.sh`; if packaging output changes, commit the generated artifacts alongside the manifest updates.

## Constraints / Risks

- Follow APM package anatomy: skills belong under `.apm/skills/`, not ad hoc directories.
- Keep the package name, directory name, root manifest entry, and README references identical once normalized.
- The repo’s CI uses the same validation script, so any marketplace or pack drift must be fixed before handoff.
