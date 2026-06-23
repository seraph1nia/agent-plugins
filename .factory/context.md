Project bearings for `wf-c970c139`:

- Repo shape: APM marketplace with root `apm.yml`, single package at `plugins/factory/apm.yml`, and generated Claude marketplace output in `.claude-plugin/marketplace.json`; see `README.md`.
- Validation contract: CI runs `mise exec -- scripts/validate.sh`, which chains `scripts/validate-claude-marketplace.sh`, `scripts/validate-apm-metadata.sh`, and `scripts/validate-apm.sh`; tool versions are pinned in `.mise.toml`.
- Validation caveat: `VALIDATION.md` documents that `apm marketplace check --offline` may warn on local `./plugins/*` sources, while `apm pack --check-clean --json` is the clean artifact check that must stay green.
- No `CONTEXT.md`, `AGENTS.md`, or `docs/adr/` files were present in this checkout.
