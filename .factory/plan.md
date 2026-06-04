# Plan: Create Claude Plugin Marketplace (BAR-25)

## References consulted

- **Plugin marketplace format**: https://code.claude.com/docs/en/plugin-marketplaces.md
- **Plugin manifest schema**: https://code.claude.com/docs/en/plugins-reference.md
- **MCP configuration in Claude Code**: https://code.claude.com/docs/en/mcp.md
- **Linear official MCP server**: https://linear.app/docs/mcp
- **Linear MCP changelog**: https://linear.app/changelog/2025-05-01-mcp

---

## Summary

Build a proper Claude Code plugin marketplace in `seraph1nia/agent-plugins`.  
Claude Code has a first-class plugin/marketplace system with a defined format: a
`.claude-plugin/marketplace.json` catalog at the repo root and one subdirectory per plugin
under `plugins/`. Each plugin has its own `.claude-plugin/plugin.json` manifest and a
`.mcp.json` for bundled MCP servers.

---

## Key technical facts (from docs)

### Marketplace catalog
- File: `.claude-plugin/marketplace.json` at repo root
- Users install via: `/plugin marketplace add github:seraph1nia/agent-plugins`
- Then install a plugin: `/plugin install factory@agent-plugins`

### Plugin structure (per plugin under `plugins/<name>/`)
- `.claude-plugin/plugin.json` — manifest (name, description, version, author …)
- `.mcp.json` — MCP server config bundled with the plugin

### Linear remote MCP (as of 2026)
- **Endpoint**: `https://mcp.linear.app/mcp` (Streamable HTTP transport)
- **SSE endpoint (`/sse`) is deprecated** — do NOT use
- **Auth**: OAuth 2.1 with dynamic client registration (interactive) **or** `Authorization: Bearer <token>` header for API-key auth
- **Recommended config** (works for all Claude Code users, handles OAuth automatically):
  ```json
  {
    "mcpServers": {
      "linear": {
        "command": "npx",
        "args": ["-y", "mcp-remote", "https://mcp.linear.app/mcp"]
      }
    }
  }
  ```
- **Alternative** (native HTTP, API-key auth with env var):
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
  The `mcp-remote` (stdio) option is more portable since it handles OAuth; the native
  `http` type requires the user to supply an API key manually.  
  **Use the `mcp-remote` form as the default** since Linear's OAuth flow is fully
  supported and doesn't require managing API keys.

---

## Deliverables

### 1. `.claude-plugin/marketplace.json`
The required marketplace catalog. Defines marketplace identity and lists the `factory` plugin.

```json
{
  "name": "agent-plugins",
  "owner": {
    "name": "seraph1nia"
  },
  "description": "Personal Claude Code plugin collection",
  "metadata": {
    "pluginRoot": "./plugins"
  },
  "plugins": [
    {
      "name": "factory",
      "source": "./plugins/factory",
      "description": "Equips Claude Code agents with Linear access for AI-driven software-delivery pipelines",
      "author": {
        "name": "seraph1nia"
      },
      "keywords": ["linear", "project-management", "factory", "mcp"]
    }
  ]
}
```

### 2. `plugins/factory/.claude-plugin/plugin.json`
Plugin manifest for the `factory` plugin.

```json
{
  "name": "factory",
  "displayName": "Factory",
  "version": "1.0.0",
  "description": "Equips Claude Code agents with Linear access for AI-driven software-delivery pipelines via Linear's official remote MCP server",
  "author": {
    "name": "seraph1nia"
  },
  "keywords": ["linear", "project-management", "mcp"],
  "mcpServers": "./.mcp.json"
}
```

### 3. `plugins/factory/.mcp.json`
MCP server configuration bundled with the plugin. Uses `mcp-remote` with Linear's official
Streamable HTTP endpoint (not the deprecated SSE endpoint).

```json
{
  "mcpServers": {
    "linear": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://mcp.linear.app/mcp"]
    }
  }
}
```

### 4. Updated `README.md`
Full marketplace documentation:
- What this repo is
- How Claude Code's plugin system works (brief)
- How to add this marketplace: `/plugin marketplace add github:seraph1nia/agent-plugins`
- How to install a plugin: `/plugin install factory@agent-plugins`
- Plugin table (name, description, MCP servers included)
- Reference links: Linear MCP docs, Claude Code plugin marketplace docs

---

## File Inventory

| File | Action | Notes |
|------|--------|-------|
| `README.md` | Rewrite | Marketplace docs, install guide, plugin table, reference links |
| `.claude-plugin/marketplace.json` | Create | Official marketplace catalog format |
| `plugins/factory/.claude-plugin/plugin.json` | Create | Plugin manifest |
| `plugins/factory/.mcp.json` | Create | Linear official remote MCP (mcp-remote, HTTP transport) |

---

## Constraints / Notes

- No build system, tests, or CI needed — this is a documentation/config repo.
- `mcp-remote` approach handles OAuth 2.1 automatically; no manual API key needed.
- SSE endpoint (`https://mcp.linear.app/sse`) is deprecated — use `/mcp`.
- `${LINEAR_API_KEY}` env-var form is documented as an alternative in the plugin README.
- The marketplace name `agent-plugins` is not on the reserved list and is safe to use.
- Schema note: `"$schema": "https://json.schemastore.org/claude-code-plugin-manifest.json"` can be added for editor autocomplete but is ignored at runtime.
