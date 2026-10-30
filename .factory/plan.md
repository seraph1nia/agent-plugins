# Plan: Add `coding-standards` plugin

1. Add a new package at `plugins/coding-standards/apm.yml` following the existing package shape from `plugins/factory/apm.yml`.
   - Use the same target runtimes and package type unless inspection of the plugin schema requires otherwise.
   - Give it a description/tags that reflect coding standards and project bootstrap helpers.

2. Add the plugin-local skill assets for the three requested behaviors.
   - One skill for installing `vite-plus` and creating a default config file when none exists.
   - One skill for creating `.mise.toml` and pinning Node to a specific version.
   - One skill for ensuring non-frontend packages use `nodeNext`.
   - Keep the skill file layout consistent with whatever package-local convention the repo/packager accepts.

3. Register the new package in the marketplace manifests.
   - Update root `apm.yml` so the marketplace package list includes `coding-standards` with the correct source path under `./plugins`.
   - Regenerate `.claude-plugin/marketplace.json` so the committed Claude marketplace artifact matches the manifest.

4. Validate the result against the repo checks.
   - Run `mise exec -- scripts/validate.sh`.
   - Confirm the new package does not disturb the existing `factory` package or the generated marketplace drift check.

5. Keep an eye on packaging risks.
   - If the skill files are not picked up by `apm pack` automatically, adjust the package layout rather than inventing new repository-level conventions.
   - Preserve the pinned toolchain and existing validation behavior; do not change the `apm-cli` or Node version unless the packaging format forces it.
