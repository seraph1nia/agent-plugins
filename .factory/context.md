# Context: Add Matt Pocock Plugin

## Project Memory
No `CONTEXT.md` or `docs/adr/` exists in this repo. Project memory is only in `README.md` and `VALIDATION.md`.

## Domain

This is a personal APM (Agent Package Manager) marketplace at `seraph1nia/agent-plugins`. It publishes agent plugins for consumption via the `apm` CLI.

Key concepts:
- **Marketplace manifest**: root `apm.yml` — lists all packages under `marketplace.packages`
- **Plugin manifest**: `plugins/<name>/apm.yml` — per-plugin metadata, target runtimes, and dependencies
- **Generated artifact**: `.claude-plugin/marketplace.json` — produced by `apm pack`, must be committed and kept in sync with the manifests

## Existing Precedent

The only current plugin is `factory` (`plugins/factory/apm.yml`):
- `type: hybrid`
- targets `claude` and `codex`
- has an MCP dependency (Linear's remote MCP server via `npx mcp-remote`)

## APM Plugin Types (from schema)

Supported `type` values in APM manifests include:
- `hybrid` — combination of prompt and MCP
- `mcp` — pure MCP dependency
- `prompt` — pure system-prompt skill injection

For Matt Pocock's dev skills (TypeScript expertise), `type: prompt` with a `system_prompt` field is the right fit — no MCP server is needed.

## Constraints

- After any manifest change, `apm pack` **must** be re-run to regenerate `.claude-plugin/marketplace.json`, and that regenerated file must be committed.
- `apm-cli` is installed via `pipx install apm-cli==0.18.0` (or via mise); the binary is `apm`.
- The validation entrypoint is `scripts/validate.sh`. CI runs it via the workflow at `.github/workflows/validation.yml`.
- Plugin names in `apm.yml` and `marketplace.json` must match the directory name under `plugins/`.
- Each plugin in `marketplace.json` requires: `name`, `description`, `license`, `homepage`, `repository`, `source`, `author.name`, `tags` (non-empty array).

## Matt Pocock — Dev Profile

Matt Pocock is a prominent TypeScript educator (Total TypeScript). His most-used dev skills:
1. **TypeScript strict mode** — `"strict": true`, explicit return types, no `any`
2. **Zod** — runtime schema validation tied to TypeScript types
3. **Vitest** — fast unit/integration testing (replaces Jest)
4. **tsup** — zero-config TypeScript library bundler
5. **tRPC** — end-to-end type-safe API layer

## Files to Touch

| File | Action |
|------|--------|
| `plugins/matt-pocock/apm.yml` | Create — plugin manifest |
| `apm.yml` | Update — add package entry to `marketplace.packages` |
| `.claude-plugin/marketplace.json` | Regenerate via `apm pack` |
| `README.md` | Update — add row to Available Packages table and Package Details section |
