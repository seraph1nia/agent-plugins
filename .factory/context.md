# Context

- Repo is an APM marketplace: `apm.yml` defines the marketplace and `plugins/factory/apm.yml` defines the `factory` package.
- README is the human-facing entrypoint for install/use docs; keep the existing marketplace/package sections intact and add the poem without disturbing the manifest story.
- Validation path is `scripts/validate.sh` via `.github/workflows/validation.yml`; docs-only changes should not touch generated marketplace artifacts unless intentionally regenerating them.
- No `CONTEXT.md`, `AGENTS.md`, or `docs/adr/` files were present in this checkout.
