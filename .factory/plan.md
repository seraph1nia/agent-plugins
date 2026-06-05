# Plan: Move to APM (BAR-27)

## Goal

Migrate the repo from the Claude-specific `.claude-plugin` format to
[APM (Agent Package Manager)](https://microsoft.github.io/apm/producer/) — Microsoft's
multi-target package system. Treat the repo as an **APM marketplace** containing multiple
packages (currently one: `factory`). Update README with the new workflow.

---

## Current State

```
.claude-plugin/
  marketplace.json              # Claude-plugin marketplace catalog
plugins/
  factory/
    .claude-plugin/
      plugin.json               # Claude-plugin manifest
    .mcp.json                   # Linear MCP server config
README.md
```

---

## Target State

```
apm.yml                         # Root marketplace manifest (APM)
plugins/
  factory/
    apm.yml                     # Factory package manifest (APM)
README.md                       # Rewritten for APM workflow
.factory/
  plan.md                       # This file
  TASKS.md                      # (added by task agent)
```

Files to **delete** (old format, replaced by APM):
- `.claude-plugin/marketplace.json`
- `plugins/factory/.claude-plugin/plugin.json`
- `plugins/factory/.mcp.json`  ← MCP config migrates into `plugins/factory/apm.yml`

---

## Implementation

### 1. Create `/apm.yml` (root marketplace manifest)

```yaml
name: agent-plugins
version: 1.0.0
description: Personal Claude Code plugin collection — a marketplace of AI coding agent packages
author: seraph1nia
license: MIT

marketplace:
  owner:
    name: seraph1nia
    url: https://github.com/seraph1nia
  packages:
    - name: factory
      source: seraph1nia/agent-plugins
      subdir: plugins/factory
      description: Equips Claude Code agents with Linear access for AI-driven software-delivery pipelines
      tags: [linear, project-management, factory, mcp]
```

Key points:
- `marketplace.packages[].source` = `owner/repo` shorthand for the **same** repo
- `subdir` points to the package directory within this repo
- Additional packages can be appended to `packages:` as the marketplace grows

### 2. Create `/plugins/factory/apm.yml` (package manifest)

```yaml
name: factory
version: 1.0.0
description: Equips Claude Code agents with Linear access for AI-driven software-delivery pipelines via Linear's official remote MCP server
author: seraph1nia
license: MIT
target: [claude, codex, gemini, copilot, cursor]
type: hybrid
includes: auto

dependencies:
  mcp:
    - name: linear
      transport: stdio
      registry: false
      command: npx
      args: ["-y", "mcp-remote", "https://mcp.linear.app/mcp"]
```

Key points:
- `target` covers all major agent/IDE platforms
- `type: hybrid` (combines instructions + skills/prompts)
- `includes: auto` publishes all content under `.apm/` (none currently, future-proofing)
- MCP dependency uses `registry: false` + `stdio` transport via `mcp-remote` — matches
  the existing `.mcp.json` behaviour exactly (OAuth flow via `mcp-remote`)

### 3. Delete old format files

- `rm .claude-plugin/marketplace.json` (and the `.claude-plugin/` dir if empty)
- `rm plugins/factory/.claude-plugin/plugin.json` (and `.claude-plugin/` dir)
- `rm plugins/factory/.mcp.json`

### 4. Rewrite `README.md`

Replace the "How Claude Code's plugin system works" and "Getting started" sections with
APM-centric content. Keep the Available plugins table and plugin details section but
update command examples.

New install flow to document:
```bash
# Install the apm CLI (once)
npm install -g @microsoft/apm

# Install the factory package from this marketplace
apm install seraph1nia/agent-plugins --package factory

# Or reference the marketplace in your own apm.yml
dependencies:
  apm:
    - seraph1nia/agent-plugins/plugins/factory
```

Update "Repository layout" section to reflect new file structure.
Update reference links to point at APM docs instead of Claude Code plugin docs.

---

## Constraints & Risks

- **Backward compat**: Removing `.claude-plugin/` files breaks anyone who installed via
  the old `/plugin marketplace add` flow. Acceptable since the issue explicitly requests
  this migration. The README update covers the new path.
- **`.apm/` directory**: Not needed right now — the `factory` plugin has no skill/prompt
  primitives, only an MCP dependency. The manifest alone is sufficient; `includes: auto`
  is harmless when `.apm/` is absent.
- **mcp-remote OAuth**: The `stdio` + `npx mcp-remote` approach is preserved verbatim
  from the old `.mcp.json`, so OAuth behaviour is unchanged.
- **No build step required**: APM requires `apm compile`/`apm pack` for publishing, but
  the repo itself just needs the manifest files committed. Consumers `apm install` from
  the GitHub source directly.
