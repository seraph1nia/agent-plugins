# Plan: test poem xxx

## Scope
- Add a 4-line poem to `README.md`.
- Keep the change docs-only; do not touch `apm.yml` or `.claude-plugin/marketplace.json`.

## Approach
1. Append a small new README section near the end of the file so the existing marketplace documentation stays intact.
2. Write exactly four short lines of poem text with stable Markdown line breaks.
3. Review the diff to confirm only `README.md` changed and the poem stayed at four lines.

## Constraints
- Preserve the current README structure and tone outside the new poem section.
- Do not regenerate marketplace artifacts for this task.

## Validation
- Manual diff check only; no functional tests are expected for a README-only edit.
