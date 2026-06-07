Requested changes:

1. Pin/install the required APM CLI through the checked-in toolchain instead of installing the latest package at runtime. `.mise.toml` only declares Node and Python, while `scripts/ensure-apm.sh` runs `python -m pip install --upgrade --user apm-cli` without a version. That leaves the CI result dependent on whatever `apm-cli` publishes next, and it misses the issue requirement to include `.mise.toml` entries for required global packages. Please make the APM CLI version deterministic, preferably via mise-managed tooling, or otherwise pin the exact `apm-cli` version used by the validation scripts.

2. Make the documented local command path work from a fresh checkout. With current `mise`, `mise install` fails until the repository config is trusted, and running `scripts/validate.sh` outside an activated/mise-managed shell cannot find the Python toolchain. The README/VALIDATION instructions currently only say `mise install` followed by `scripts/validate.sh`; please update the local workflow or wrapper so users can run the validation reliably, for example by documenting `mise trust` and `mise exec -- scripts/validate.sh` or by providing an equivalent committed entrypoint.

Validation performed:

- `git diff origin/main...HEAD --check` passed.
- `scripts/validate-claude-marketplace.sh` passed with the ambient Node runtime.
- `scripts/validate.sh` failed before mise setup because `apm` and `python` were unavailable.
- After installing mise locally, `mise install` failed until `.mise.toml` was trusted.
- After `mise trust .mise.toml`, `mise install` passed and `mise exec -- scripts/validate.sh` passed.
