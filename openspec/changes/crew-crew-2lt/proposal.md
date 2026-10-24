# Proposal

## Why

The agent-plugins repository already publishes APM manifests, but its validation repeats packaging work, tolerates an overly broad offline-check failure, and does not demonstrate package-install compatibility. Finish the refactoring by establishing an explicit authoring contract and testing the supported consumer behavior rather than treating the existing integration as proof of a completed migration.

## What Changes

- **Proposed for human approval:** make root `apm.yml` authoritative for marketplace metadata and `plugins/*/apm.yml` authoritative for package metadata and dependencies. The current README describes this arrangement, but this proposal does not treat it as an approved design decision.
- **Proposed for human approval:** retain committed `.claude-plugin/marketplace.json` as APM-generated compatibility output, not a second authoring source. Do not remove it or rename the repository, marketplace, package directories, or consumer identifiers.
- Consolidate validation behind the existing `scripts/validate.sh` interface, preserving callable validation scripts where practical and avoiding duplicate pack execution in the aggregate path.
- Fail closed on metadata errors; permit only a narrowly verified APM 0.18.0 local-source offline-cache limitation, with successful structural and clean-pack checks still mandatory.
- Add deterministic validator regressions and isolated real-APM checks for package installation and runtime MCP configuration. Document which evidence is automated, which requires network access, and which remains manual.
- Update maintainer and consumer documentation with the approved authoring workflow, compatibility guarantees, toolchain requirements, and reproducible validation instructions.

## Capabilities

### New Capabilities

- `apm-marketplace-maintenance`: APM authoring authority, retained consumer compatibility, deterministic publishing validation, and isolated package-consumption verification.

### Modified Capabilities

None. `openspec/specs/` contains only `.gitkeep`; there are no canonical capabilities to modify.

## Impact

Likely affected files are `README.md`, `VALIDATION.md`, validation scripts and new regression fixtures, `.github/workflows/validation.yml`, and (only if verified necessary) the existing manifests/generated metadata. Keep APM 0.18.0 and the current mise-managed toolchain unless a separate approval changes that scope. Preserve `seraph1nia/agent-plugins`, marketplace `agent-plugins`, package `factory` version `1.0.0`, Claude/Codex targets, and the Linear stdio MCP command.

No intended breaking changes. Deleting compatibility artifacts, adopting APM-only consumers, moving `plugins/`, changing package functionality, upgrading APM, renaming the project, and publishing releases are out of scope. Approval of this plan authorizes the proposed authoring contract and compatibility retention, not a subsequent removal migration. If a reviewer chooses a different authority model, revise this plan before implementation.
