# BAR-65 Plan: Add `matpocock` Linear-Targeted SDLC Skills

## Context

- Fresh plan; `.factory/plan.md` did not previously exist.
- Linear issue thread has no additional product answers beyond the issue description.
- Current repo is a small APM marketplace with one package:
  - root `apm.yml`
  - `plugins/factory/apm.yml`
  - generated `.claude-plugin/marketplace.json`
  - `README.md`
  - validation scripts under `scripts/`
- Upstream `mattpocock/skills` main currently resolves to `2bf70051928429983de3b5718d277150926f8c89`.

## Approach

1. Create `plugins/matpocock/` as a new APM package.
   - Add `plugins/matpocock/apm.yml` with `name: matpocock`, `type: skill`, `target: [claude]`, `license: MIT`, and a package dependency on `factory` from marketplace `agent-plugins`.
   - If `apm pack` rejects intra-marketplace package dependencies, use the issue's fallback: duplicate the `factory` Linear MCP dependency shape in this package and document the deviation.

2. Vendor only the requested upstream skills.
   - Copy from `mattpocock/skills`:
     - `skills/engineering/grill-with-docs/SKILL.md`
     - `skills/engineering/grill-with-docs/CONTEXT-FORMAT.md`
     - `skills/engineering/grill-with-docs/ADR-FORMAT.md`
     - `skills/engineering/to-prd/SKILL.md`
     - `skills/engineering/to-issues/SKILL.md`
   - Preserve upstream skill directory names: `grill-with-docs`, `to-prd`, `to-issues`.
   - Confirm APM 0.18.0's expected skill layout before finalizing paths. Upstream Claude plugin uses `.claude-plugin/plugin.json` with skill paths like `./skills/engineering/to-prd`; this repo's APM `type: skill` may expect either a `skills/` tree or top-level skill directories.

3. Adapt the three skills minimally for Linear.
   - Remove the instruction to run `/setup-matt-pocock-skills`.
   - State that the tracker is Linear and available through the `factory` package dependency.
   - For `to-prd`, publish the PRD to Linear and apply the ready-for-agent triage label if available in the workspace.
   - For `to-issues`, fetch referenced Linear issues via Linear MCP, create child/sliced Linear issues in dependency order, and avoid GitHub/local-file branches.
   - `grill-with-docs` is mostly tracker-agnostic; keep its `CONTEXT.md` and ADR behavior, plus its two referenced format docs.

4. Include attribution and license.
   - Add a package-level `LICENSE` containing Matt Pocock's MIT license text.
   - Add concise attribution, likely in `plugins/matpocock/README.md`, naming `mattpocock/skills`, the vendored commit, and the adapted Linear default.
   - Preserve copyright notice.

5. Register the package in the marketplace.
   - Add a `matpocock` entry to root `apm.yml` under `marketplace.packages`:
     - `source: ./plugins/matpocock`
     - homepage pointing to this repo's package directory
     - repository `https://github.com/seraph1nia/agent-plugins`
     - author/maintainer metadata
     - `license: MIT`
     - tags such as `linear`, `sdlc`, `skills`, `prd`, `issues`

6. Update docs.
   - Add `matpocock` to README "Available Packages".
   - Add a package detail section explaining that it installs Claude skills for a Linear-first `grill-with-docs -> to-prd -> to-issues` workflow and depends on `factory`.
   - Update the repository layout snippet to include `plugins/matpocock/`.

7. Regenerate generated metadata.
   - Run `apm pack` through the repo-supported toolchain.
   - Commit the resulting `.claude-plugin/marketplace.json`.
   - Do not hand-edit `.claude-plugin/marketplace.json`.
   - Verify it lists both `factory` and `matpocock`, with the generated `matpocock` source as `./matpocock`.

8. Validate.
   - Run `mise exec -- scripts/validate.sh`.
   - Expected gates:
     - Claude marketplace JSON structural check
     - APM metadata check
     - `apm pack --check-clean --json` with clean/unchanged drift
   - Current planning environment lacks `mise` and `apm` on PATH, so implementation must run these in an environment with the pinned toolchain installed.

## Files/Areas To Change

- Add `plugins/matpocock/apm.yml`.
- Add vendored skill files under the APM-confirmed skill directory layout.
- Add `plugins/matpocock/LICENSE`.
- Add `plugins/matpocock/README.md` or equivalent attribution docs.
- Update root `apm.yml`.
- Regenerate `.claude-plugin/marketplace.json`.
- Update `README.md`.

## Constraints And Risks

- The exact APM 0.18.0 layout for package-contained Claude `SKILL.md` files is the main unknown; confirm by running `apm pack` before locking in paths.
- `factory` cannot serve as a skill package template because it only declares an MCP dependency.
- The intra-marketplace dependency on `factory` is required by the issue, but may need the documented fallback if APM rejects it.
- Adaptations should be narrow and attributable; avoid rewriting Matt Pocock's skills into a new workflow.
- Do not include out-of-scope upstream skills or Codex support.
- `.claude-plugin/marketplace.json` is generated and must remain clean after validation.
