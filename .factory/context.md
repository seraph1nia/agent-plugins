# Context

No `CONTEXT.md`, `AGENTS.md`, or `docs/adr/` files are present in this repo.

- Current layout: root `apm.yml` defines the marketplace and `plugins[]`; `plugins/factory/apm.yml` is the only existing package.
- Generated Claude marketplace artifact: `.claude-plugin/marketplace.json`, validated by `scripts/validate-claude-marketplace.sh`.
- Repo validation depends on `apm pack --check-clean --json` via `scripts/validate-apm.sh` and `scripts/validate.sh`.
- Keep new package sources local under `./plugins/<name>` to match the existing `factory` package pattern.
