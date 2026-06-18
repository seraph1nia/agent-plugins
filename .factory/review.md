Requested changes:

1. Regenerate `.claude-plugin/marketplace.json` from the updated root `apm.yml` so the published marketplace artifact includes the new `grill-me` package alongside `factory`.
2. Ensure the committed generated artifact matches the manifest change exactly; the current file still lists only `factory`, which makes the repo inconsistent.
3. Re-run the repo validation flow after regeneration and commit any resulting artifact updates.
