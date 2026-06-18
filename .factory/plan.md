Plan for `ws-5f0e0f14`:

1. Inspect the current validation path and confirm what the smoke test should exercise in this repo: repository metadata, generated Claude marketplace artifact, and the packaged plugin manifest.
2. Add the smallest possible smoke-test step or script hook to run the existing validation entrypoint end-to-end in the same way CI does, reusing `scripts/validate.sh` and the pinned mise/apm toolchain.
3. If the smoke test needs fixture/output updates, keep them aligned with the committed marketplace artifact and the existing `factory` package metadata only.
4. Verify the smoke path locally with the repo’s validation command and ensure the generated artifact remains clean.
5. Commit `.factory/context.md` and `.factory/plan.md`, then push the branch for the next stage.

Constraints and risks:

- Do not change the marketplace/package schema unless validation forces it; this repo’s contract is already documented and CI-backed.
- Preserve the committed `.claude-plugin/marketplace.json` if packing stays clean, because consumers rely on that generated artifact.
- `apm marketplace check` has a known offline/local-source caveat in `VALIDATION.md`; prefer the existing `scripts/validate.sh` path for smoke coverage.
