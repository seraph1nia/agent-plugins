# BAR-33 Plan: GitHub Workflow Validation

## Current State

- The repo is an APM marketplace with root `apm.yml`, generated `.claude-plugin/marketplace.json`, and one plugin package at `plugins/factory/apm.yml`.
- `VALIDATION.md` documents successful `apm pack --json` and `apm pack --check-clean --json` runs with APM CLI 0.18.0.
- `VALIDATION.md` also documents that `apm marketplace check` currently fails for the local package source `./plugins/factory` despite the schema allowing local sources, so the pipeline should not depend on that command unless the underlying issue is resolved.
- There are no validation scripts, `.mise.toml`, or GitHub workflow files yet.

## Implementation Approach

1. Add `.mise.toml` at the repo root to pin global tools required by local and CI validation.
   - Include Python for the `apm-cli` package.
   - Include Node.js because the plugin dependency uses `npx mcp-remote` and validation may need npm-based CLI tooling.
   - Use mise tasks only if they simplify local invocation without hiding the actual scripts.

2. Add local validation scripts under `scripts/`.
   - `scripts/validate-apm.sh`: install or verify `apm`, then run `apm pack --check-clean --json` from the repo root.
   - `scripts/validate-claude-marketplace.sh`: run the closest available Claude marketplace/plugin validation command. First verify the exact CLI that is installable in CI; if no standalone `claude marketplace plugin validate` command exists, document the fallback and validate `.claude-plugin/marketplace.json` structurally.
   - `scripts/validate.sh`: orchestrate all validation steps so the same entrypoint works locally and in CI.
   - Keep scripts POSIX-ish bash with strict mode, repo-root detection, clear error output, and no machine-specific paths.

3. Add Microsoft APM validation requests at all applicable levels.
   - Marketplace level: validate root `apm.yml` and generated `.claude-plugin/marketplace.json` via APM commands.
   - Plugin level: validate `plugins/factory/apm.yml` via APM-supported packaging or schema validation.
   - Skills level: only add a check if the repo gains a `skills/` tree or if APM CLI exposes a skills validation command that succeeds against an empty/missing skills directory. Do not create fake skill content solely to satisfy the wording.

4. Add a GitHub Actions workflow in `.github/workflows/validation.yml`.
   - Trigger on pull requests and pushes to `main`.
   - Start the job steps with `jdx/mise-action` or the current official mise action before any validation commands.
   - Run `mise install`, then `scripts/validate.sh`.
   - Avoid duplicating validation command lists in YAML; the workflow should call the local script.

5. Update docs.
   - Add local validation instructions to `README.md` or `VALIDATION.md`.
   - Mention the exact script entrypoint, required mise command, and any known APM CLI limitation that remains relevant.

## Verification

- Run `mise install` locally.
- Run `scripts/validate.sh` locally and confirm it succeeds.
- Confirm `apm pack --check-clean --json` reports clean generated marketplace output.
- Confirm `git status --short` shows no generated artifact drift after validation.

## Constraints and Risks

- The exact Claude marketplace validation command must be verified during implementation; the issue wording is approximate.
- `apm marketplace check` currently appears unsuitable for this repo because it fails on the valid local package source. Prefer `apm pack --check-clean --json` unless a newer APM CLI fixes the issue.
- Keep tool installation deterministic through `.mise.toml`; avoid relying on preinstalled global packages in GitHub Actions.
