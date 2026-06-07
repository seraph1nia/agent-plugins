# Plan: Move to APM (BAR-27)

## Goal

Migrate this repository from the Claude Code `.claude-plugin` format to Agent Package
Manager (APM). The root repository should become an APM marketplace that can contain
multiple packages; today it will list the existing `factory` package. Update the README
so consumers use APM commands and dependency syntax instead of Claude plugin commands.

## Current State

```text
.claude-plugin/
  marketplace.json
plugins/
  factory/
    .claude-plugin/
      plugin.json
    .mcp.json
README.md
```

The existing `factory` plugin only contributes one MCP server configuration:

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

## Target State

```text
apm.yml
.claude-plugin/
  marketplace.json
.agents/
  plugins/
    marketplace.json
plugins/
  factory/
    apm.yml
README.md
.factory/
  plan.md
```

Remove the obsolete Claude plugin package files after their data has been represented in
APM:

- `plugins/factory/.claude-plugin/plugin.json`
- `plugins/factory/.mcp.json`

Replace the existing hand-authored `.claude-plugin/marketplace.json` with marketplace
output generated from APM, if `apm pack` produces it.

## Implementation Approach

1. Add root `apm.yml` as the marketplace authoring manifest.
   - Include normal package fields: `name`, `version`, `description`, `author`, `license`.
   - Add a `marketplace:` block with `owner`, metadata, and `packages`.
   - Use the recommended `marketplace.outputs` map so the marketplace can emit both
     Claude and Codex marketplace files:
     `claude.output: .claude-plugin/marketplace.json` and
     `codex.output: .agents/plugins/marketplace.json`.
   - List `factory` as a local package source: `source: ./plugins/factory`.
   - Include required marketplace entry fields such as `version`, `description`, `tags`,
     and `category` for Codex output.
   - Keep the marketplace ready for multiple packages by using the `packages:` list rather
     than a single-package shortcut.

2. Add `plugins/factory/apm.yml` as the package manifest.
   - Port `name`, `version`, `description`, `author`, and keywords/tags from the old
     Claude manifest.
   - Set targets to the supported agent runtimes this repo intends to serve, including
     `claude` and `codex`; confirm exact target names against `apm targets` or the docs
     before implementation.
   - Declare the Linear MCP dependency in `dependencies.mcp` using the existing
     `npx -y mcp-remote https://mcp.linear.app/mcp` command so OAuth behaviour is
     preserved.

3. Delete the old Claude plugin manifests.
   - Remove empty `.claude-plugin` directories after deleting their files.
   - Do not change unrelated branch or factory scaffolding files.

4. Rewrite `README.md` around APM.
   - Describe the repo as an APM marketplace, not a Claude Code marketplace.
   - Replace `/plugin marketplace add` and `/plugin install` examples with APM flows:
     `apm marketplace add seraph1nia/agent-plugins` followed by
     `apm install factory@agent-plugins`, plus direct dependency examples using
     `dependencies.apm`.
   - Keep the `factory` description and Linear OAuth/API-key notes, updating any local
     config references so they are not Claude-only unless explicitly called out as a
     Claude override.
   - Update repository layout and reference links to APM producer, marketplace, manifest,
     MCP, and Linear docs.

5. Validate.
   - Run a YAML parse/check if available.
   - Prefer `apm marketplace check`, `apm pack --dry-run`, and `apm install
     ./plugins/factory --dry-run` if the CLI is installed; otherwise note that validation
     could not run locally.
   - Confirm `git status` shows only the intended migration files.

## Constraints and Risks

- The APM docs require remote marketplace package entries to declare a `version` or `ref`;
  using `source: ./plugins/factory` avoids an unnecessary remote self-reference for this
  monorepo-style marketplace. The local marketplace entry should still include `version`
  for generated output metadata.
- Removing `.claude-plugin` files intentionally breaks the old Claude `/plugin` install
  flow. Keeping an APM-generated Claude marketplace artifact may preserve compatibility
  for Claude consumers, but README should still make APM the supported path.
- The old plugin has no `.apm/` primitives, only an MCP dependency. The package manifest
  may be sufficient, but implementation should verify whether APM expects any placeholder
  package content for MCP-only packages.
- APM target names have changed over time; verify the exact supported list during
  implementation before committing target values.
- `mcp-remote` depends on `npx` at runtime and triggers Linear OAuth on first use; this is
  existing behaviour and should remain unchanged.

## References

- https://microsoft.github.io/apm/producer/
- https://microsoft.github.io/apm/reference/manifest-schema/
- https://microsoft.github.io/apm/reference/cli/marketplace/
- https://microsoft.github.io/apm/producer/publish-to-a-marketplace/
