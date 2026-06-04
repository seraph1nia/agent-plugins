# Plan: Create Claude Plugin Marketplace (BAR-25)

## Summary

Build a Claude Code plugin marketplace in the `seraph1nia/agent-plugins` repository.
A "plugin" here is a pre-packaged MCP server configuration (plus docs) that Claude Code
users can browse and install. The repo currently has only a barebones README.

---

## Deliverables

### 1. Updated `README.md`
Transform the placeholder README into a proper marketplace index covering:
- What this repo is (a curated collection of Claude Code MCP plugin bundles)
- What a plugin is and how it integrates with Claude Code
- Directory layout explanation
- How to install a plugin (copy `mcp.json` into `.claude/settings.json` or `mcp.json`)
- A table of available plugins (starting with `factory`)
- Reference links to Claude Code MCP documentation

### 2. `plugins/` directory
Each plugin lives in its own subdirectory:
```
plugins/
└── factory/
    ├── README.md   # plugin-level docs
    └── mcp.json    # MCP server configuration
```

### 3. `plugins/factory/mcp.json`
The "factory" plugin wires up Linear's **official remote MCP server** so Claude Code
agents in the factory pipeline can read/write Linear issues without a local binary.

Linear's remote MCP endpoint (SSE transport, API-key auth):
```json
{
  "mcpServers": {
    "linear": {
      "type": "sse",
      "url": "https://mcp.linear.app/sse",
      "headers": {
        "Authorization": "Bearer ${LINEAR_API_KEY}"
      }
    }
  }
}
```

> Reference: Linear's official MCP docs at https://linear.app/docs/mcp

### 4. `plugins/factory/README.md`
Documents the factory plugin:
- Purpose: equips Claude Code with Linear access for AI-driven software delivery pipelines
- Prerequisites: a Linear API key (personal or workspace token)
- Installation steps
- Available Linear MCP tools/capabilities

---

## File Inventory

| File | Action | Notes |
|------|--------|-------|
| `README.md` | Rewrite | Full marketplace docs, plugin table, install guide |
| `plugins/factory/mcp.json` | Create | Linear remote MCP (SSE) config |
| `plugins/factory/README.md` | Create | Factory plugin docs |

---

## Constraints / Notes

- No build system, tests, or CI is needed — this is a documentation/config repo.
- The `mcp.json` format uses `type: "sse"` for remote servers; Claude Code supports
  both `stdio` (local process) and `sse`/`http` (remote) transports.
- API keys are referenced as `${LINEAR_API_KEY}` env-var placeholders — never hardcoded.
- The Linear SSE endpoint (`https://mcp.linear.app/sse`) is Linear's canonical remote
  MCP URL as of 2026; confirm in plugin README so users know where the reference comes from.
