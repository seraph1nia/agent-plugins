# agent-plugins

A personal APM marketplace hosted at `seraph1nia/agent-plugins`.

This repository publishes agent packages through [Agent Package Manager](https://microsoft.github.io/apm/). The root `apm.yml` is the marketplace authoring manifest, and each plugin package keeps its own `apm.yml` under `plugins/`.

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
.claude-plugin/
  marketplace.json
plugins/
  factory/
    apm.yml
```

The root `apm.yml` contains marketplace metadata and the `marketplace.packages` list. `.claude-plugin/marketplace.json` is generated from the root manifest and must be committed so consumers can register and install from this marketplace. `plugins/factory/apm.yml` contains the package metadata, target runtimes, and Linear MCP dependency.

## Maintainer Commands

```sh
apm marketplace check
apm pack
apm pack --check-clean
```

Use `apm marketplace check` while authoring the root marketplace manifest. Use `apm pack` to produce `.claude-plugin/marketplace.json`, then commit that generated artifact with the manifest change. Use `apm pack --check-clean` before publishing to confirm the committed marketplace artifact matches the current manifests.

## References

- [APM producer guide](https://microsoft.github.io/apm/producer/)
- [APM package installation](https://microsoft.github.io/apm/consumer/install-packages/)
- [APM marketplace CLI](https://microsoft.github.io/apm/reference/cli/marketplace/)
- [APM manifest schema](https://microsoft.github.io/apm/reference/manifest-schema/)
- [Linear MCP server docs](https://linear.app/docs/mcp)
- [`mcp-remote`](https://www.npmjs.com/package/mcp-remote)
