# Context
- No repo-local `CONTEXT.md` or `docs/adr/` were present, so there is no existing glossary/ADR to honor.
- Repo shape: APM marketplace root manifest at `apm.yml`, one package at `plugins/factory/apm.yml`, and generated Claude marketplace output at `.claude-plugin/marketplace.json`.
- Relevant work area: `README.md` opens with a four-line poem; recent history shows this stanza is the intended change surface.
- Constraint: keep the change localized to README prose; do not alter manifests or generated marketplace artifacts for a poem-only edit.
