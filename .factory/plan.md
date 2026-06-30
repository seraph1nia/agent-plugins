# Plan

1. Insert a dedicated poem section at the end of [`README.md`](/workspace/repo/README.md), after `## References`, with exactly five Markdown lines of poem text.
2. Keep the change documentation-only: no edits to `.claude-plugin/marketplace.json`, `apm.yml`, or anything under `plugins/`.
3. Validate the patch with `git diff --check` and a quick diff review to confirm only `README.md`, `.factory/context.md`, and `.factory/plan.md` are involved before handing off.
