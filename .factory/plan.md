# Plan

Add a second APM package for the Mat Pokock "grill me" skill only.

1. Inspect the intended package naming and source layout from the existing marketplace conventions, then add a new `plugins/<name>/apm.yml` for the skill-only package.
2. Update root `apm.yml` so the marketplace publishes the new package alongside `factory`.
3. Regenerate `.claude-plugin/marketplace.json` from the updated manifest so the committed artifact matches the marketplace.
4. Update `README.md` only if the published package list or install example needs to reflect the new plugin.
5. Validate with the repo's normal checks, especially `scripts/validate.sh` and `apm pack --check-clean --json`.

Constraints:

- Keep the new package minimal: only the single grill-me skill dependency, no extra skills or MCP services.
- Follow the existing package manifest shape and naming patterns used by `factory`.
- Do not diverge from generated marketplace output; commit any regenerated artifact together with the manifest change.
