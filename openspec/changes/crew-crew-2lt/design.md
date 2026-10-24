# Design

## Context

See `proposal.md` for motivation and the proposed approval decisions. The assigned checkout contains agent-plugins content despite its orchestrator-owned worktree path. There is no checkout-local `AGENTS.md` or nested instruction file. The supplied orchestrator instructions and execution skill govern this planning session; the checkout's `.github/workflows/validation.yml` defines its actual implementation checks, not the orchestrator's npm commands.

Observed integration:

- Root `apm.yml` declares one marketplace entry sourced from `./plugins/factory`; `plugins/factory/apm.yml` declares the hybrid package, two runtime targets, and Linear MCP dependency.
- `.claude-plugin/marketplace.json` contains the generated entry with source `./factory` relative to `metadata.pluginRoot: ./plugins`. These paths are deliberately different and must not be normalized blindly.
- `.mise.toml` pins `pipx:apm-cli` 0.18.0 with Python/uv, plus Node 24.13.0. `ensure-apm.sh` also hardcodes the version and prepends `$HOME/.local/bin`, potentially shadowing mise's selected executable.
- `validate.sh` runs structural JSON validation, metadata checking plus pack checking, and a second pack check. The metadata exception merely matches any local plugin source in the manifest and `No cached refs` anywhere in combined output; it does not prove that all failures are benign.
- CI installs tools via mise and invokes the shared entrypoint. No regression suite or consumer smoke suite exists in this checkout. `VALIDATION.md` is historical evidence with `/workspace` paths, not evidence from this planning session.
- Only `.gitkeep` exists under canonical specs. Shell execution is prohibited during Explore; no CLI behavior or previous validation output has been independently reproduced here.

## Goals / Non-Goals

**Goals:** put validation policy behind the existing small command interface; make failure classification testable; verify both metadata generation and actual package consumption; preserve current consumer contracts.

**Non-Goals:** introduce a general package-management abstraction, new runtimes/packages, a generator competing with APM, tool upgrades, repository renames, releases, or removals of compatibility output. Live Linear access/OAuth is not needed to verify configuration.

## Decisions

### 1. Propose APM authoring with retained Claude compatibility

Upon human approval, manifests become the authoring authority and committed Claude metadata remains derived output. Use `apm pack` to regenerate intentionally and `apm pack --check-clean --json` to validate. This follows the existing toolchain while making the policy explicit rather than silently ratifying the README.

Alternatives: maintain independent handwritten metadata (rejected because it creates drift); remove Claude metadata/APM-only consumption (rejected because no removal or breaking migration is approved); retain the ambiguous current policy (rejected because maintenance remains unclear). Human rejection of the recommended policy requires plan revision before Apply.

### 2. Consolidate existing validation, not add a parallel framework

Keep `scripts/validate.sh` as the external interface shared by local use and CI. Its implementation runs structural validation, metadata checking, and one pack/drift verification per aggregate execution. Retain existing standalone script entrypoints as adapters to shared checks; avoid gratuitous script deletion. Keep fixture/report classification behind an internal seam so tests can supply command outputs while production invokes real APM. This concentrates failure policy without exposing callers to phase-ordering details.

Resolve APM from the active toolchain PATH instead of unconditionally prioritizing `$HOME/.local/bin`. Verify the expected version consistently against the pinned repository configuration, with a regression protecting against pin/check divergence. Do not add runtime installation. Preserve explicit setup diagnostics and the existing mise re-exec behavior, testing its recursion guard and wrong-version case.

Alternatives: retain repeated pack calls (no additional assurance); replace shell validation wholesale (unnecessary migration); build a generic runner/interface (too much surface for one real CLI).

### 3. Scope the offline exception to proven failures

Before implementation, capture exact APM 0.18.0 offline diagnostics in an isolated fixture. Prefer structured diagnostics if that version exposes them; otherwise accept only a complete recognized diagnostic shape with every failing source matched to an actual local marketplace entry. Do not accept merely because substrings appear. Unrecognized diagnostics, extra errors, remote sources, malformed output, and subprocess failures outside the proven limitation remain fatal. Successful pack validation does not excuse unrelated metadata errors.

A narrow exception is preferred over disabling metadata checks or allowing every offline failure. The exact parser representation is an implementation detail, but the fail-closed acceptance contract is fixed. If the pinned CLI cannot distinguish the known condition safely, stop implementation and report that evidence for plan revision; do not broaden the exception or upgrade APM silently.

### 4. Separate deterministic tests from real CLI smoke checks

Use shell/Node facilities already installed. Regression fixtures exercise the scripts through their command interface with an injected fake `apm` on isolated PATH; they must test exit statuses, diagnostics, invocation counts, and unchanged files. Include an assertion that aggregate validation invokes pack once while the standalone pack entrypoint still works.

Real-APM smoke checks create a temporary local Git marketplace and disposable consumer projects under `/tmp/opencode` when available. Use the fixture's local registration reference only for transport; retain marketplace/package names. Isolate HOME, XDG configuration/cache, and any CLI-specific state after inspecting 0.18.0 behavior. Exercise `factory@agent-plugins` and the documented project dependency form in separate projects, inspect actual installed outputs for Claude and Codex, and assert exact Linear command/arguments without starting MCP or performing OAuth. Never substitute fake outputs for real installation evidence. Do not depend on remote publication of the branch or modify consumer global state.

CI runs deterministic regressions and real-APM smoke checks alongside the normal entrypoint using the existing mise pin. If installation requires external dependency resolution, document and isolate those network requirements; no Linear access or user credentials are permitted. Inability to perform the required smoke checks is a concrete verification blocker, not an implicit pass.

## Risks / Trade-offs

- [APM 0.18.0 diagnostics may not safely support the exception] → Capture actual reports first; fail closed and request a revised plan if classification cannot meet the spec.
- [CLI state paths or runtime output layout are not verified] → Inspect pinned behavior during Apply, assert configuration isolation, and record observed paths in tests/docs; never run against real user state.
- [Generated metadata alone does not prove native Claude plugin execution] → Preserve existing metadata and verify its resolution paths; claim only the APM installation/configuration behavior exercised. A new native Claude execution guarantee is outside scope.
- [A local smoke fixture differs from GitHub delivery] → Verify local APM behavior automatically, preserve public identifiers, and document optional remote checks separately without treating them as executed evidence.
- [Version selection changes expose previously shadowed executables] → Test valid, absent, and wrong-version environments and keep actionable mise guidance.
- [Historical validation notes appear authoritative] → Replace machine-specific examples with reproducible commands and clearly dated actual results; never fabricate successful execution.

## Migration Plan

1. Obtain human approval of the authority/compatibility decisions before application edits.
2. Reproduce current validation and pinned CLI diagnostics in disposable environments; add regression fixtures before changing policy.
3. Refactor the existing scripts, retain entrypoint compatibility, and implement isolated real-APM consumption checks.
4. Regenerate metadata only if an intentional manifest change requires it; verify the factory package contract and unchanged public paths.
5. Update CI and docs, then execute deterministic tests, shell syntax checks, real consumer smoke checks, and the shared validation entrypoint. Record exact commands/results and any blockers.

No release, push, archive, or resource removal is performed by the worker. Changes are ordinary tracked repository edits with no production data migration. If delivery must be rolled back, the controller can deliver a follow-up restoring the previous scripts/docs/manifests together while retaining compatible generated metadata; do not delete or rewrite user resources.
