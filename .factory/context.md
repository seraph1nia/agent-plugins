# Work Context

- No `CONTEXT.md`, `AGENTS.md`, or `docs/adr/` files are present in this checkout.
- Repo is an APM marketplace: root [`apm.yml`](../apm.yml) defines marketplace metadata; [`plugins/factory/apm.yml`](../plugins/factory/apm.yml) defines the only package.
- Keep the committed generated Claude artifact in sync with the manifests: [`.claude-plugin/marketplace.json`](../.claude-plugin/marketplace.json).
- Validation is script-driven via [`scripts/validate.sh`](../scripts/validate.sh), which calls the Claude marketplace check and APM pack checks.
- Existing README content documents the marketplace, install flow, and the `factory` package description; this task appears scoped to a README wording tweak only.
