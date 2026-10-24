# APM Marketplace Maintenance

## Purpose

Provide a reliable APM authoring and validation workflow while preserving existing marketplace discovery, package identities, and supported runtime configuration.

## ADDED Requirements

### Requirement: Authoritative manifests and compatible generated output

The repository SHALL use root `apm.yml` for marketplace authoring and package `apm.yml` files for package authoring. It SHALL retain committed `.claude-plugin/marketplace.json` as generated compatibility output, and validation SHALL reject missing or stale generated output without rewriting tracked files.

#### Scenario: Manifest change requires regeneration
- **WHEN** marketplace authoring changes without updating its generated Claude metadata
- **THEN** validation fails and identifies the stale output
- **AND** the maintainer can regenerate the output through the documented APM publishing command

#### Scenario: Clean checkout validation
- **WHEN** all manifests and generated metadata agree
- **THEN** publishing validation succeeds without modifying tracked files

### Requirement: Existing consumer behavior is preserved

The repository SHALL preserve repository reference `seraph1nia/agent-plugins`, marketplace name `agent-plugins`, package name `factory`, version `1.0.0`, and existing local package paths. The factory package SHALL retain Claude and Codex targets and its Linear MCP dependency using stdio command `npx` with arguments `-y`, `mcp-remote`, and `https://mcp.linear.app/mcp`. Both marketplace-qualified installation and the documented project-manifest dependency form SHALL remain supported.

#### Scenario: Install through marketplace registration
- **WHEN** a consumer registers this marketplace and installs `factory@agent-plugins` with the supported APM CLI
- **THEN** the factory package resolves without requiring renamed identifiers
- **AND** its supported runtime configuration preserves the declared Linear MCP command and arguments

#### Scenario: Install through a project manifest
- **WHEN** a consumer declares dependency name `factory` and marketplace `agent-plugins` in a project manifest and installs dependencies
- **THEN** APM resolves the same factory package and Linear MCP dependency

### Requirement: Validation fails closed

The documented validation entrypoint SHALL reject unavailable or unsupported APM versions, invalid metadata, failed generation checks, malformed reports, and dirty generated output. An offline metadata-check failure SHALL be tolerated only when every reported failure is verified to be the known APM 0.18.0 missing-cache condition for a declared local package source and independent structural and clean-pack checks succeed. Unknown, mixed, remote-source, or unparseable failures SHALL fail validation. Validation SHALL NOT install tools or silently upgrade the pinned CLI.

#### Scenario: Known local offline limitation
- **WHEN** the only metadata-check failures are verified missing-cache failures for declared local sources under APM 0.18.0
- **AND** structural and clean-pack checks succeed
- **THEN** validation reports the limitation as a warning and succeeds

#### Scenario: Cache warning accompanied by another failure
- **WHEN** metadata checking reports a missing-cache condition and any unrelated error
- **THEN** validation fails rather than allowing the cache condition to mask that error

#### Scenario: Invalid pack report
- **WHEN** packaging exits unsuccessfully, returns malformed JSON, reports failure, omits the expected marketplace output, or lacks a successful unchanged drift report
- **THEN** validation fails

#### Scenario: Unsupported environment
- **WHEN** APM is missing or does not match the repository-supported version
- **THEN** validation fails with actionable setup guidance without installing or upgrading tools

### Requirement: Reproducible and isolated verification

Local and CI verification SHALL use the documented validation entrypoint and include deterministic regression checks for validation failures. Package-install smoke checks SHALL exercise real supported APM behavior in disposable consumer environments without modifying the user's home configuration, contacting Linear, requesting OAuth, pushing to remotes, or publishing packages. Documentation SHALL distinguish automated checks from manual evidence and limitations.

#### Scenario: Validator regression suite
- **WHEN** the deterministic suite runs without network access
- **THEN** it verifies valid output, drift, malformed output, missing output, tool errors, known local cache failures, and mixed or unknown metadata failures

#### Scenario: Consumer smoke verification
- **WHEN** package-install verification runs against a disposable local marketplace fixture
- **THEN** both documented dependency forms and the Claude/Codex MCP configuration are checked using the pinned real APM CLI
- **AND** user configuration and credentials remain untouched

#### Scenario: Required smoke check cannot run
- **WHEN** the environment cannot provide isolated real-APM package-install verification
- **THEN** verification reports a failure or explicit blocker rather than recording a passing or silently skipped check
