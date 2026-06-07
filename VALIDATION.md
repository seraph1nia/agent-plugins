# Validation

## Local Checks Run

```sh
node - <<'NODE'
const fs = require('fs');
const allowedTargets = new Set(['vscode','agents','copilot','claude','cursor','opencode','codex','gemini','windsurf','all']);
const allowedTypes = new Set(['instructions','skill','hybrid','prompts']);
const files = ['apm.yml', 'plugins/factory/apm.yml'];
for (const file of files) {
  const text = fs.readFileSync(file, 'utf8');
  if (!/^name: [A-Za-z0-9._-]+$/m.test(text)) throw new Error(`${file}: missing name`);
  if (!/^version: \d+\.\d+\.\d+$/m.test(text)) throw new Error(`${file}: missing semver version`);
  if (/^author:\s*$/m.test(text)) throw new Error(`${file}: top-level author must be a string`);
  const targets = [...text.matchAll(/^\s+- (claude|codex|vscode|agents|copilot|cursor|opencode|gemini|windsurf|all)$/gm)].map(m => m[1]);
  for (const target of targets) if (!allowedTargets.has(target)) throw new Error(`${file}: invalid target ${target}`);
  const type = text.match(/^type: (\S+)$/m)?.[1];
  if (type && !allowedTypes.has(type)) throw new Error(`${file}: invalid package type ${type}`);
}
const root = fs.readFileSync('apm.yml', 'utf8');
if (!/^marketplace:\n/m.test(root)) throw new Error('root manifest missing marketplace block');
if (!/^\s+owner:\n\s+name: seraph1nia$/m.test(root)) throw new Error('marketplace owner missing');
if (!/^\s+packages:\n\s+- name: factory\n\s+source: \.\/plugins\/factory$/m.test(root)) throw new Error('marketplace package list missing factory local source');
const pkg = fs.readFileSync('plugins/factory/apm.yml', 'utf8');
for (const pattern of [/^dependencies:\n\s+mcp:/m, /^\s+- name: linear$/m, /^\s+registry: false$/m, /^\s+transport: stdio$/m, /^\s+command: npx$/m]) {
  if (!pattern.test(pkg)) throw new Error(`factory manifest missing ${pattern}`);
}
console.log('schema-shape validation OK');
NODE
```

## APM CLI Validation

The APM CLI was not installed in this local environment, so `apm marketplace check` could not be run here.

Run these checks in an environment with APM installed:

```sh
apm marketplace check
apm marketplace validate agent-plugins
apm pack
```
