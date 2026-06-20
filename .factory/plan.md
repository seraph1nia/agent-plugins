# Plan: ws-062906dc — Add CONTRIBUTING.md

## Goal
Create `CONTRIBUTING.md` at the repo root containing a one-paragraph overview of the repository.

## Approach
Add a single new file. No existing files need modification.

The paragraph should cover:
- What this repo is (a personal APM marketplace for agent plugins)
- How it is structured (`apm.yml` + `plugins/` layout, generated `.claude-plugin/marketplace.json`)
- How to contribute a new plugin (add a directory under `plugins/` with its own `apm.yml`, run `apm pack` to regenerate the marketplace artifact, commit both)
- How to validate changes before opening a PR (`mise exec -- scripts/validate.sh`)

## File to Create
| Path | Action |
|------|--------|
| `CONTRIBUTING.md` | Create — one-paragraph overview |

## Notes
- Keep it brief: the work item explicitly asks for a one-paragraph overview.
- Draw on README.md for accurate terminology (APM, marketplace, `apm pack`, `apm.yml`).
- No other files need to change; the CONTRIBUTING.md is documentation only and does not affect validation or the generated artifact.
