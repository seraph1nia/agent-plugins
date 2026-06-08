# BAR-64 Plan: Move Workflow Actions to Latest Major Versions

## Context

- The only GitHub Actions workflow in this repo is `.github/workflows/validation.yml`.
- Current action pins:
  - `actions/checkout@v4`
  - `jdx/mise-action@v3`
- Latest release check at planning time:
  - `actions/checkout` has a newer major release (`v6`), so the workflow should move to `actions/checkout@v6`.
  - `jdx/mise-action` is already on the latest major (`v3`), so it should remain `jdx/mise-action@v3` unless a newer major is confirmed during implementation.
- The workflow currently has a separate `Install toolchain` step that runs `mise install` after the mise setup action. The issue asks for the mise setup job to install tools too, so that separate step should be folded into the `jdx/mise-action` configuration.

## Implementation Approach

1. Update `.github/workflows/validation.yml`:
   - Change `actions/checkout@v4` to `actions/checkout@v6`.
   - Configure `jdx/mise-action@v3` to install the toolchain directly, replacing `install: false` with the action-supported install setting.
   - Remove the separate `Install toolchain` step.
   - Keep the validation command as `mise exec -- scripts/validate.sh`.

2. Re-check action majors before editing if implementation happens later:
   - Confirm `actions/checkout` latest major is still `v6`.
   - Confirm `jdx/mise-action` latest major is still `v3`.

3. Validate locally:
   - Run `scripts/validate.sh` if the local environment already has mise/APM available.
   - If local mise/APM setup is unavailable, at minimum verify workflow YAML syntax/shape by inspection and document that full validation depends on GitHub Actions.

## Files to Change

- `.github/workflows/validation.yml`

## Constraints and Risks

- `actions/checkout@v6` may have runner/runtime requirements different from `v4`; keep `runs-on: ubuntu-latest` unless release notes require otherwise.
- `jdx/mise-action` install behavior must match the action's supported inputs. The goal is to have the setup action run installation, not to add another shell install command.
- `.mise.toml` already pins the repo toolchain (`node`, `python`, `uv`, and `pipx:apm-cli`); no version changes are expected there unless validation shows the action cannot install one of those tools.
