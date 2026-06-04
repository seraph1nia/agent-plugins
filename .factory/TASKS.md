# Tasks: Create Claude Plugin Marketplace (BAR-25)

- [x] 1. Create `.claude-plugin/marketplace.json` — the root marketplace catalog that lists the `factory` plugin and allows users to add this repo via `/plugin marketplace add github:seraph1nia/agent-plugins`
- [x] 2. Create `plugins/factory/.mcp.json` — the Linear official remote MCP server config (using `mcp-remote` + `https://mcp.linear.app/mcp`; not the deprecated SSE endpoint)
- [x] 3. Create `plugins/factory/.claude-plugin/plugin.json` — the factory plugin manifest (name, version, description, author, keywords, `mcpServers` pointer to `./.mcp.json`)
- [x] 4. Rewrite `README.md` with full marketplace documentation: what this repo is, how Claude Code's plugin system works, add-marketplace and install-plugin commands, a plugin table (name, description, included MCP servers), and reference links (Linear MCP docs, Claude Code plugin marketplace docs)
