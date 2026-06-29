# Work context for wf-9739d248

- Repo: APM marketplace `seraph1nia/agent-plugins`.
- Relevant domain terms from `README.md` / manifests: root marketplace manifest (`apm.yml`), plugin package (`plugins/factory/apm.yml`), generated Claude marketplace artifact (`.claude-plugin/marketplace.json`), validation scripts under `scripts/`.
- Conventions/constraints:
  - Keep `.claude-plugin/marketplace.json` committed and in sync with `apm.yml`; only regenerate it intentionally via `apm pack`.
  - Use `scripts/validate.sh` as the repo validation entrypoint; it chains Claude marketplace JSON checks, APM metadata checks, and `apm pack --check-clean --json`.
  - Local marketplace sources use `./plugins/...`; offline APM metadata checks may warn about missing cached refs, but the clean pack output is the publishing guardrail.
- No `CONTEXT.md`, `AGENTS.md`, or ADRs were present in this checkout.