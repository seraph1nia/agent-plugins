# Tasks

## 1. Establish pinned behavior and authoring contract

- [ ] 1.1 After controller-recorded plan approval, reproduce `mise exec -- scripts/validate.sh` with the existing pinned toolchain in an isolated environment; record command, version, exit status, and observed limitations in `VALIDATION.md`, distinguishing new evidence from historical claims.
- [ ] 1.2 Capture sanitized APM 0.18.0 offline-check and pack reports from a disposable local marketplace as regression fixtures; verify that all missing-cache failures can be attributed exclusively to declared local sources. Stop and report for plan revision if safe classification is impossible.
- [ ] 1.3 Document the approved manifest-authority/generated-output policy in `README.md`, retaining marketplace/package names, versions, paths, and both installation examples; verify the documented source mapping matches `apm.yml`, `plugins/factory/apm.yml`, and `.claude-plugin/marketplace.json` including its relative `./factory` path.

## 2. Make validation reliable and deterministic

- [ ] 2.1 Add an offline shell/Node regression harness using disposable fixtures and an injected fake APM executable; verify it captures exit status, diagnostics, invocation counts, and file modifications without touching user configuration or requiring network access. Document its runnable command alongside the harness.
- [ ] 2.2 Refactor tool selection/version checking to respect the active toolchain PATH and the repository pin without runtime installation; verify regression cases for missing APM, wrong version, correct version, PATH shadowing, and mise re-exec recursion prevention. Update maintainer troubleshooting instructions with tested behavior.
- [ ] 2.3 Replace the broad offline-cache substring exception with fail-closed classification of the captured pinned diagnostics and actual manifest sources; verify tests for the recognized local-only condition, remote-source errors, mixed failures, unknown output, malformed diagnostics, and metadata success.
- [ ] 2.4 Consolidate structural and pack/drift validation while retaining standalone script entrypoints; verify aggregate validation invokes pack once and standalone checks still work. Cover missing/invalid marketplace JSON, duplicate names, failed pack exit, malformed report, `ok=false`, missing expected output, missing/failed drift, stale output, and successful clean output.
- [ ] 2.5 Update `README.md` and `VALIDATION.md` with the new check ordering, narrow exception policy, regeneration versus read-only validation commands, and regression command; verify every described failure policy corresponds to a passing regression and no historical result is presented as current evidence.

## 3. Verify real consumer compatibility

- [ ] 3.1 Add a real pinned-APM smoke harness with a disposable local Git marketplace and isolated HOME/XDG/APM state under `/tmp/opencode` when available; verify all state stays within fixture directories and neither user credentials, user configuration, remote publication, nor live MCP processes are used. Document state isolation and any external resolution requirements.
- [ ] 3.2 Exercise marketplace registration plus `factory@agent-plugins` installation and the documented project-manifest dependency form in separate fixture consumers; verify real APM resolves the same package and emits Claude/Codex configuration with stdio `npx -y mcp-remote https://mcp.linear.app/mcp`, without launching Linear or OAuth. Record actual output locations and fail explicitly if either consumer path cannot be verified.
- [ ] 3.3 Add assertions protecting `agent-plugins`, `factory` version `1.0.0`, the existing source paths, supported targets, dependency metadata, and generated Claude source resolution; verify the assertions pass on the current contract and reject intentionally mutated fixture identities or MCP arguments.
- [ ] 3.4 Update consumer and validation documentation with tested installation/configuration behavior, CLI version, smoke command, and limitations; verify examples match smoke fixtures and distinguish local automatic evidence from optional remote or native-Claude execution checks.

## 4. Integrate and verify the complete workflow

- [ ] 4.1 Wire deterministic regressions and real-APM smoke checks into `.github/workflows/validation.yml` with the existing mise toolchain and shared validation entrypoint; verify CI commands match the documented local commands and failures cannot be silently skipped or converted to success.
- [ ] 4.2 Run `bash -n` on changed shell scripts, the documented deterministic regression suite, the real-APM smoke suite, and `mise exec -- scripts/validate.sh`; record exact results in `VALIDATION.md` and report environment/CLI blockers instead of claiming unexecuted checks passed.
- [ ] 4.3 Review the final diff for absence of unapproved renames, compatibility-file removal, tool upgrades, user-state modifications, and unrelated content changes; verify clean-pack checks leave tracked files unchanged and present the implementation evidence for controller review without committing, publishing, archiving, or delivering changes.
