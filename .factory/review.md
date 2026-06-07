Requested changes:

1. Commit the generated marketplace artifact. The branch removes `.claude-plugin/marketplace.json` but the new root `apm.yml` only declares the marketplace authoring source. APM producer docs describe `apm pack` as writing `.claude-plugin/marketplace.json` by default, and consumers use the generated `marketplace.json` when registering/installing from a marketplace. Run `apm pack` and commit the generated `.claude-plugin/marketplace.json` so `apm marketplace add seraph1nia/agent-plugins` / `apm install factory@agent-plugins` can resolve the package.

2. Replace the ad hoc regex validation with real APM validation before marking this done. `VALIDATION.md` says the APM CLI was not installed, so the migration was not validated with the toolchain that consumes these files. After generating the artifact, run and record the actual commands, at minimum `apm marketplace check` and `apm pack --check-clean` (or the current equivalent), so schema drift and generated-artifact drift are caught.

3. Update the maintainer README commands to include the generated artifact flow. The README currently lists `apm pack`, but it does not say that the generated marketplace file must be committed. That leaves future changes likely to repeat the current broken state.
