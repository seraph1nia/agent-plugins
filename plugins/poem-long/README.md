# poem-long

`poem-long` is an APM prompt package for drafting substantial poems from a single natural-language brief.

## What it installs

- A Claude command named `/poem-long`
- A prompt source at `.apm/prompts/poem-long.prompt.md`

## Usage

Install the package from this marketplace:

```sh
apm install poem-long@agent-plugins
```

Then invoke the Claude command with the topic and any optional constraints folded into one brief:

```text
/poem-long a long poem about a city learning how to breathe again after rain, in luminous free verse with recurring bridge imagery
```

If the brief does not specify a tone, form, or target length, the prompt chooses fitting defaults and still aims for a genuinely long poem rather than a short lyric.
