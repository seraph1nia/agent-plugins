# Validation

## APM CLI

Installed the official APM CLI 0.18.0 from the `apm-cli` Python package after the prebuilt Linux binary failed on this container's glibc version.

```sh
PATH=/workspace/.local/bin:$PATH apm --version
```

Output:

```text
Agent Package Manager (APM) CLI version 0.18.0
```

## Checks Run

Run all local validation through the script entrypoint:

```sh
mise install
scripts/validate.sh
```

Generated the marketplace artifact from the root marketplace manifest:

```sh
PATH=/workspace/.local/bin:$PATH apm pack --json
```

Output:

```json
{
  "ok": true,
  "dry_run": false,
  "warnings": [],
  "errors": [],
  "marketplace": {
    "outputs": [
      {
        "format": "claude",
        "path": "/workspace/repo/.claude-plugin/marketplace.json",
        "added": 0,
        "updated": 0,
        "unchanged": 1,
        "skipped": 0
      }
    ]
  },
  "bundle": null,
  "plugin_manifests": {
    "written": [],
    "skipped": [],
    "dry_run": []
  },
  "version_alignment": null,
  "drift": null
}
```

Verified the committed marketplace artifact is current:

```sh
PATH=/workspace/.local/bin:$PATH apm pack --check-clean --json
```

Output:

```json
{
  "ok": true,
  "dry_run": false,
  "warnings": [],
  "errors": [],
  "marketplace": {
    "outputs": [
      {
        "format": "claude",
        "path": "/workspace/repo/.claude-plugin/marketplace.json",
        "added": 0,
        "updated": 0,
        "unchanged": 1,
        "skipped": 0
      }
    ]
  },
  "bundle": null,
  "plugin_manifests": {
    "written": [],
    "skipped": [],
    "dry_run": []
  },
  "version_alignment": null,
  "drift": {
    "ok": true,
    "outputs": [
      {
        "format": "claude",
        "path": ".claude-plugin/marketplace.json",
        "status": "unchanged",
        "differences": []
      }
    ]
  }
}
```

The validation scripts use `apm marketplace check --offline` for the Microsoft APM marketplace authoring metadata check and `apm pack --check-clean --json` for clean generated marketplace output.

Known limitation from manual validation: the non-offline marketplace authoring validation failed:

```sh
PATH=/workspace/.local/bin:$PATH apm marketplace check
```

Result: failed in APM 0.18.0 for the local package source `./plugins/factory` with `Git authentication failed during ls-remote.` The manifest schema documents local marketplace package sources beginning with `./` as valid and says they skip git resolution, while `apm pack` successfully consumes the local package source and generates the marketplace artifact.
