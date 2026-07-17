# agent-plugins

`agent-plugins` is the source repository for the `seraph1nia/agent-plugins` [Agent Package Manager](https://microsoft.github.io/apm/) marketplace.

The repository is primarily marketplace metadata and validation tooling:

- the root `apm.yml` defines the published marketplace
- `plugins/*/apm.yml` contains package manifests
- `.claude-plugin/marketplace.json` is the generated Claude marketplace artifact that must stay committed
- `scripts/` and `.github/workflows/validation.yml` keep the published metadata valid

The marketplace currently publishes one package, `factory`, which equips Claude and Codex agents with Linear access through Linear's official remote MCP server.

## Getting Started

### Register the Marketplace

```sh
apm marketplace add seraph1nia/agent-plugins --name agent-plugins
```

This lets APM resolve packages from this repository by marketplace name.

### Install a Package

```sh
apm install factory@agent-plugins
```

You can also declare the package directly in a project manifest:

```yaml
dependencies:
  apm:
    - name: factory
      marketplace: agent-plugins
```

Then run:

```sh
apm install
```

## Available Packages

| Package | Description | Dependencies |
| --- | --- | --- |
| `factory` | Equips agents with Linear access for AI-driven software-delivery pipelines | Linear MCP server via `mcp-remote` |

## Package Details

### `factory`

The `factory` package configures Linear's official remote MCP server as a self-defined APM MCP dependency. APM installs it for the supported runtimes declared by the package manifest:

- `claude`
- `codex`

The MCP server is launched with:

```sh
npx -y mcp-remote https://mcp.linear.app/mcp
```

`mcp-remote` starts Linear's OAuth flow on first use and caches the token after authorization.

## Repository Layout

```text
apm.yml
.mise.toml
.claude-plugin/
  marketplace.json
.github/
  workflows/
    validation.yml
plugins/
  factory/
    apm.yml
scripts/
  validate.sh
  validate-apm-metadata.sh
  validate-apm.sh
  validate-claude-marketplace.sh
```

The root `apm.yml` contains marketplace metadata and the `marketplace.packages` list. `.claude-plugin/marketplace.json` is generated from the root manifest and must be committed so consumers can register and install from this marketplace. `plugins/factory/apm.yml` contains the package metadata, target runtimes, and Linear MCP dependency. `.mise.toml` pins the local toolchain, and the validation workflow runs `scripts/validate.sh` in CI.

## Maintainer Commands

Install the local validation toolchain with [mise](https://mise.jdx.dev/):

```sh
mise trust .mise.toml
mise install
```

Run the same validation entrypoint used by CI:

```sh
mise exec -- scripts/validate.sh
```

The top-level validation script also re-executes through `mise exec` when mise is available and `apm` is not already on `PATH`, so `scripts/validate.sh` works from a normal shell after the repository config is trusted and installed. The validation entrypoint verifies the pinned Python `apm-cli` package from `.mise.toml`, structurally checks `.claude-plugin/marketplace.json`, runs applicable APM metadata checks, and confirms `apm pack --check-clean --json` reports clean generated marketplace output.

`apm marketplace check --offline` is included because it is the Microsoft APM authoring check for marketplace metadata. APM CLI 0.18.0 may report missing cached refs for this repository's local package source (`./plugins/factory`), and the non-offline form may attempt git resolution for that same local source; `apm pack --check-clean --json` is the publishing check that succeeds for this aggregator layout and verifies the generated Claude marketplace artifact.

Use `apm pack` directly only when intentionally regenerating `.claude-plugin/marketplace.json`, then commit that generated artifact with the manifest change.

## References

- [APM producer guide](https://microsoft.github.io/apm/producer/)
- [APM package installation](https://microsoft.github.io/apm/consumer/install-packages/)
- [APM marketplace CLI](https://microsoft.github.io/apm/reference/cli/marketplace/)
- [APM manifest schema](https://microsoft.github.io/apm/reference/manifest-schema/)
- [Linear MCP server docs](https://linear.app/docs/mcp)
- [`mcp-remote`](https://www.npmjs.com/package/mcp-remote)
