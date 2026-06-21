# Context

- No `CONTEXT.md`, `AGENTS.md`, or `docs/adr/` files are present in this repo.
- Current marketplace shape:
  - root `apm.yml` defines the marketplace and its package list.
  - `plugins/factory/apm.yml` is the only existing package.
  - `.claude-plugin/marketplace.json` is generated from the root manifest and must stay committed and clean.
- Validation path:
  - `scripts/validate.sh` runs Claude marketplace validation, APM metadata checks, and `apm pack --check-clean --json`.
  - Keep any new package compatible with that generated-output check.
- Package layout convention:
  - keep new package sources local under `./plugins/<name>` to match the existing `factory` package pattern.
- Work-item-specific bearing:
  - treat the public `mattpocock/skills` repo as the source of truth for the new developer-skills bundle.
