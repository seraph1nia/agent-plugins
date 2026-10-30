# Context

- No `CONTEXT.md`, `AGENTS.md`, or `docs/adr/` files are present in this checkout.
- Marketplace source of truth is root `apm.yml`; generated Claude metadata lives in `.claude-plugin/marketplace.json` and is committed.
- Plugin packages live under `plugins/<name>/apm.yml`; current package pattern is `plugins/factory/apm.yml` with `target: [claude, codex]` and `type: hybrid`.
- Validation runs through `scripts/validate.sh`, which expects `apm` from the pinned `apm-cli` toolchain in `.mise.toml` and checks both the Claude marketplace JSON and APM package output.
- Keep any new package compatible with the existing local-source layout (`./plugins/...`) so `apm pack --check-clean --json` stays clean.
