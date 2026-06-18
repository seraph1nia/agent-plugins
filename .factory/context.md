Project bearings for `ws-5f0e0f14`:

- Repo is an APM marketplace: root `apm.yml` is the marketplace manifest, `plugins/factory/apm.yml` is the single package manifest, and `.claude-plugin/marketplace.json` is committed generated output. See `README.md` and `VALIDATION.md`.
- Validation contract: CI runs `mise exec -- scripts/validate.sh`; it should verify pinned `apm-cli` 0.18.0, check marketplace metadata, and confirm `apm pack --check-clean --json` is clean. See `.github/workflows/validation.yml` and `scripts/validate.sh`.
- Current package scope: `factory` targets `claude` and `codex`, and its MCP dependency is Linear via `mcp-remote`/`https://mcp.linear.app/mcp`. See `plugins/factory/apm.yml` and `apm.yml`.
- No `CONTEXT.md`, `AGENTS.md`, or `docs/adr/` were present in this checkout.
