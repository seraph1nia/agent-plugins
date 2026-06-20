# Context: ws-062906dc

## Work Item
Add a short CONTRIBUTING.md with a one-paragraph overview of the repo.

## Project Memory
- No `CONTEXT.md`, `AGENTS.md`, or `docs/adr/` exist in this repo.

## Repo Summary (from README.md and apm.yml)
- `seraph1nia/agent-plugins` is a personal APM (Agent Package Manager) marketplace.
- It publishes agent packages via the [Agent Package Manager](https://microsoft.github.io/apm/).
- Root `apm.yml` is the marketplace authoring manifest; each plugin has its own `apm.yml` under `plugins/`.
- Currently one plugin: `factory` — equips agents with Linear access via Linear's remote MCP server.
- Generated artifact: `.claude-plugin/marketplace.json` must be committed after any manifest change (`apm pack`).
- Validation: `mise exec -- scripts/validate.sh` (requires mise + pinned `apm-cli` 0.18.0).

## Constraints
- No existing CONTRIBUTING.md — this is a new file.
- Scope: one paragraph overview only (per work item description).
- No ADRs or recorded decisions bearing on contribution guidelines.
