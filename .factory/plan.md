# Plan: Add Matt Pocock Plugin

## Goal

Add a new APM plugin named `matt-pocock` that encodes Matt Pocock's most-used TypeScript development skills as a system-prompt plugin. Register it in the marketplace and regenerate the Claude marketplace artifact.

## Approach

Use APM `type: prompt` with a `system_prompt` field. This is the correct type for skill injection — no MCP server is required. The plugin targets the `claude` runtime.

Matt Pocock's five core dev skills to encode:
1. TypeScript strict mode — `strict: true`, explicit types, no implicit `any`
2. Zod — schema-first validation, infer TS types from schemas
3. Vitest — colocated tests, `describe`/`it`, `.toEqual` for type-level assertions
4. tsup — zero-config bundler for TypeScript libraries (`tsup src/index.ts`)
5. tRPC — end-to-end type safety, router/procedure pattern

## Implementation Steps

### 1. Create `plugins/matt-pocock/apm.yml`

```yaml
name: matt-pocock
version: 1.0.0
description: TypeScript development skills inspired by Matt Pocock — strict types, Zod, Vitest, tsup, and tRPC
author: seraph1nia
license: MIT
target:
  - claude
type: prompt
system_prompt: |
  You are a TypeScript expert following Matt Pocock's approach to TypeScript development.

  ## TypeScript
  - Always enable strict mode (`"strict": true` in tsconfig.json)
  - Use explicit return types on all functions
  - Avoid `any`; use `unknown` and narrow with type guards
  - Prefer type inference where it's clear; annotate where it aids readability
  - Use utility types (`Pick`, `Omit`, `ReturnType`, `Parameters`, etc.) instead of duplicating types

  ## Zod
  - Define schemas first with `z.object(...)`, then infer TypeScript types with `z.infer<typeof schema>`
  - Use Zod for all runtime validation (API inputs, env vars, user data)
  - Compose schemas rather than duplicating them
  - Keep schemas colocated with the code that uses them

  ## Vitest
  - Use Vitest for all unit and integration tests
  - Colocate tests next to source files (`.test.ts` or `.spec.ts`)
  - Use `describe`/`it` blocks; prefer `it` for single assertions
  - Assert on inferred types with `expectTypeOf` from `vitest`
  - Run with `vitest run` for CI, `vitest` for watch mode

  ## tsup
  - Use tsup to bundle TypeScript libraries (`tsup src/index.ts --format cjs,esm --dts`)
  - Keep `tsup.config.ts` minimal; rely on zero-config defaults
  - Always emit `.d.ts` declarations for library packages

  ## tRPC
  - Define routers with `t.router({...})` and procedures with `t.procedure`
  - Use Zod for all procedure input/output validation
  - Keep procedure logic thin — call service functions rather than embedding logic
  - Prefer `publicProcedure` and `protectedProcedure` split for auth boundaries
```

### 2. Update root `apm.yml`

Add a new entry to `marketplace.packages`:

```yaml
    - name: matt-pocock
      source: ./plugins/matt-pocock
      description: TypeScript development skills inspired by Matt Pocock — strict types, Zod, Vitest, tsup, and tRPC
      homepage: https://github.com/seraph1nia/agent-plugins/tree/main/plugins/matt-pocock
      repository: https://github.com/seraph1nia/agent-plugins
      author:
        name: seraph1nia
      license: MIT
      tags:
        - typescript
        - zod
        - vitest
        - tsup
        - trpc
        - matt-pocock
```

### 3. Regenerate `.claude-plugin/marketplace.json`

Install apm-cli if not available:
```sh
pipx install apm-cli==0.18.0
```

Then regenerate:
```sh
apm pack
```

Commit the updated `.claude-plugin/marketplace.json`.

### 4. Update `README.md`

Add to the **Available Packages** table:
```markdown
| `matt-pocock` | TypeScript development skills inspired by Matt Pocock — strict types, Zod, Vitest, tsup, and tRPC | — |
```

Add a **Package Details › matt-pocock** section describing the skills and install command.

### 5. Validate

```sh
scripts/validate.sh
```

Expected: all three validation steps pass (Claude marketplace JSON, APM metadata, APM pack clean).

## Risks / Notes

- The exact field name for the prompt in a `type: prompt` APM manifest may be `system_prompt`, `prompt`, or `instructions` depending on the APM schema version. Verify against `apm pack` output — if it rejects the field, adjust and re-run.
- `apm marketplace check --offline` may warn about missing cached refs for local sources (known limitation documented in `VALIDATION.md`); this is non-fatal.
- No MCP dependencies are needed for this plugin, so `dependencies` is omitted entirely.
