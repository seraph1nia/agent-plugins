Repo memory relevant to this work:

- No `CONTEXT.md`, `AGENTS.md`, or `docs/adr/` files exist in this repo.
- Repo structure: root `apm.yml` defines the marketplace; each plugin lives under `plugins/<name>/apm.yml`; generated Claude marketplace artifact is `.claude-plugin/marketplace.json`.
- Current package conventions are visible in `plugins/factory/apm.yml` and root `apm.yml`.
- Validation expectation: run the repo's APM checks via `scripts/validate.sh`; `apm pack --check-clean --json` should stay clean after manifest changes.
