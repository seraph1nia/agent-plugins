# Plan

## Goal
Add a new Matt Pocock skills package to the marketplace, mirroring the upstream `mattpocock/skills` bundle and keeping the generated Claude marketplace clean.

## Scope
- Add a new local package under `plugins/mattpocock-skills/`.
- Mirror the upstream Claude bundle structure:
  - `.claude-plugin/plugin.json`
  - `skills/engineering/ask-matt`
  - `skills/engineering/diagnosing-bugs`
  - `skills/engineering/grill-with-docs`
  - `skills/engineering/triage`
  - `skills/engineering/improve-codebase-architecture`
  - `skills/engineering/setup-matt-pocock-skills`
  - `skills/engineering/tdd`
  - `skills/engineering/to-issues`
  - `skills/engineering/to-prd`
  - `skills/engineering/prototype`
  - `skills/engineering/domain-modeling`
  - `skills/engineering/codebase-design`
  - `skills/productivity/grill-me`
  - `skills/productivity/grilling`
  - `skills/productivity/handoff`
  - `skills/productivity/teach`
  - `skills/productivity/writing-great-skills`
- Add the package to root `apm.yml` with local source `./plugins/mattpocock-skills` and metadata aligned to the upstream repository.
- Regenerate `.claude-plugin/marketplace.json` from the root manifest.

## Implementation Notes
- Use the upstream bundle name `mattpocock-skills` so the package name, folder name, and Claude plugin manifest stay aligned.
- Keep the existing `factory` package untouched.
- Preserve the repo’s current validation path: root `apm.yml` -> `apm pack` -> `.claude-plugin/marketplace.json`.

## Validation
- Run `scripts/validate.sh`.
- Confirm `apm pack --check-clean --json` reports `.claude-plugin/marketplace.json` as unchanged.
- Verify the new package appears in the generated marketplace output and the package tree matches the upstream skill list exactly.

## Risks
- If any skill path differs from the upstream bundle, Claude plugin loading will break even if APM packaging succeeds.
- The new package should stay local-only; do not introduce remote sources or new auth requirements.
