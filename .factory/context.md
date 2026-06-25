Project memory for this work:

- No `CONTEXT.md` or `docs/adr/` tree is present in this checkout.
- Repository focus: APM marketplace docs and manifests for `seraph1nia/agent-plugins` (`README.md`, `apm.yml`, `.claude-plugin/marketplace.json`).
- Conventions from `README.md`: `.claude-plugin/marketplace.json` is generated and should only change when intentionally regenerating marketplace output; docs-only changes should not touch it.
- Validation reference: `scripts/validate.sh` is the repo's standard check entrypoint, but this task should only require a README edit.
