# Context

- Repo memory files were not present: no `CONTEXT.md`, no `AGENTS.md`, and no `docs/adr/` entries to inherit.
- Relevant repo terms live in [README.md](/workspace/repo/README.md): the `factory` package description and the `Package Details` section are the likely insertion point for the new tracing note.
- Keep this change docs-only. The generated marketplace artifact lives at [`.claude-plugin/marketplace.json`](/workspace/repo/.claude-plugin/marketplace.json) and should not need regeneration for a README note.
- Validation conventions are documented in [VALIDATION.md](/workspace/repo/VALIDATION.md) and [scripts/validate.sh](/workspace/repo/scripts/validate.sh); they are useful for checking that no unintended files changed, but this work should not alter package metadata.
