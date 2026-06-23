Plan for `wf-c970c139`:

1. Trace the workspace-actor smoke path against the repo’s existing validation entrypoint and identify the smallest place to encode it, preferring `scripts/` over manifest churn.
2. Add or adjust a focused smoke-test step so it exercises the workspace actor provisioning behavior after the `sandboxClass` CRD fix, while keeping the repo’s APM marketplace files unchanged unless the smoke path exposes real drift.
3. Wire the smoke check into the same CI/local entrypoint that already governs the repo, updating `.github/workflows/validation.yml` or `scripts/validate*.sh` only if the new check must run on every PR.
4. Verify the result with `mise exec -- scripts/validate.sh` and confirm `.claude-plugin/marketplace.json` still stays clean under `apm pack --check-clean --json`.

Constraints and risks:

- Keep the fix scoped to the smoke-test/validation layer; do not rewrite package metadata unless the validation output demands it.
- Preserve the committed marketplace artifact if the pack output remains unchanged.
- If the provisioning check depends on external sandbox configuration not represented in this repo, document that dependency in the validation path rather than inventing new manifest fields.
