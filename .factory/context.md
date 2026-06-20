# Workspace Bearings

- Repo: `seraph1nia/agent-plugins`, an APM marketplace repo with one existing package: `plugins/factory/apm.yml`.
- No `CONTEXT.md` or `AGENTS.md` exists in this checkout; use the repo manifests plus docs below as the source of truth.
- Relevant APM package anatomy from Microsoft docs: skills live under `.apm/skills/<name>/SKILL.md`; instructions/agents use `.apm/` primitives and compile into harness-specific outputs. See APM docs: `Instructions and agents` and `What is APM` on `microsoft.github.io/apm`.
- Marketplace/packaging convention here: root `apm.yml` is the marketplace manifest, and `.claude-plugin/marketplace.json` is generated from it and must stay committed.
- Validation gates: `scripts/validate.sh` runs `validate-claude-marketplace.sh`, `validate-apm-metadata.sh`, and `validate-apm.sh`; CI calls the same entrypoint from `.github/workflows/validation.yml`.
- Local-package constraint: `scripts/validate-apm-metadata.sh` already tolerates offline `apm marketplace check` cache misses for `./plugins/*` sources and then enforces `apm pack --check-clean --json`.
