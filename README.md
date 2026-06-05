# agent-plugins

A personal Claude Code plugin marketplace hosted at `github:seraph1nia/agent-plugins`.

This repository provides a collection of plugins that extend Claude Code with additional MCP
(Model Context Protocol) servers and capabilities. Plugins are installed directly from this
repo using Claude Code's built-in plugin system.

---

## How Claude Code's plugin system works

Claude Code has a first-class plugin/marketplace system:

- A **marketplace** is a GitHub repository with a `.claude-plugin/marketplace.json` catalog
  at its root and one plugin directory per plugin under a configurable `pluginRoot`.
- A **plugin** is a subdirectory containing:
  - `.claude-plugin/plugin.json` — plugin manifest (name, version, description, author…)
  - `.mcp.json` — one or more bundled MCP server configurations
- When you add a marketplace and install a plugin, Claude Code merges the plugin's
  `.mcp.json` into your local MCP configuration automatically.

---

## Getting started

### 1. Add this marketplace to Claude Code

```
/plugin marketplace add github:seraph1nia/agent-plugins
```

This registers the marketplace so you can browse and install its plugins.

### 2. Install a plugin

```
/plugin install factory@agent-plugins
```

Replace `factory` with the name of any plugin listed below. The `@agent-plugins` suffix
tells Claude Code which marketplace to pull from.

---

## Available plugins

| Plugin | Description | Included MCP Servers |
|--------|-------------|----------------------|
| `factory` | Equips Claude Code agents with Linear access for AI-driven software-delivery pipelines | `linear` — Linear's official remote MCP server |

---

## Plugin details

### `factory`

Connects Claude Code to [Linear](https://linear.app) via Linear's official remote MCP server.
This enables Claude Code agents (and interactive sessions) to read and write Linear issues,
comments, projects, and more — without requiring manual API key configuration.

**Authentication:** The plugin uses [`mcp-remote`](https://www.npmjs.com/package/mcp-remote)
which triggers Linear's OAuth 2.1 flow on first use. You will be prompted to authorise in
your browser; after that, the token is cached automatically.

**Alternative (API key):** If you prefer to authenticate with a Linear API key instead of
OAuth, you can override the MCP config in your local `~/.claude/mcp.json`:

```json
{
  "mcpServers": {
    "linear": {
      "type": "http",
      "url": "https://mcp.linear.app/mcp",
      "headers": {
        "Authorization": "Bearer ${LINEAR_API_KEY}"
      }
    }
  }
}
```

---

## Repository layout

```
.claude-plugin/
  marketplace.json          # Root marketplace catalog
plugins/
  factory/
    .claude-plugin/
      plugin.json           # Plugin manifest
    .mcp.json               # Linear MCP server config
```

---

## Reference links

- [Claude Code plugin marketplace docs](https://code.claude.com/docs/en/plugin-marketplaces.md)
- [Claude Code plugin manifest reference](https://code.claude.com/docs/en/plugins-reference.md)
- [Claude Code MCP configuration](https://code.claude.com/docs/en/mcp.md)
- [Linear MCP server docs](https://linear.app/docs/mcp)
- [Linear MCP changelog (May 2025)](https://linear.app/changelog/2025-05-01-mcp)
