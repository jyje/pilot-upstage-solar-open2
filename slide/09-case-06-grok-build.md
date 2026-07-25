<!-- slidev:enable-auto-animate -->
# Case 06 — Solar Open 2 × Grok Build

## xAI's terminal coding agent as a custom model

<v-click>

### How it works

Grok Build reads model definitions from `config.toml` at `$GROK_HOME/config.toml`:

```toml
[model.solar-open2]
model = "solar-open2"
base_url = "https://api.upstage.ai/v1/solar"
name = "Solar Open 2 (Upstage)"
env_key = "UPSTAGE_API_KEY"
api_backend = "chat_completions"

[models]
default = "solar-open2"
```

`api_backend = "chat_completions"` is key — unlike Codex (hard-locked to Responses API),
Grok Build lets a custom model **pick its wire protocol** per entry.

</v-click>

<v-click>

### Finding 1: Custom models only work in user-level config

Project-local `.grok/config.toml` is **silently ignored** for `[model.X]` entries.
Docs say: ["project configs are limited to MCP servers, plugins, and permission
rules, not full user configs"](https://docs.x.ai/build/settings).

**Workaround:** set `$GROK_HOME` to a throwaway temp dir with a generated
`config.toml` for the duration of the run — same isolation pattern as Case 02/03.

</v-click>

<v-click>

### Finding 2: Tool-calling breaks — same root cause as Case 05

Asking Grok Build to read a local file with its built-in file tool fails:

```
Invalid function name: ''. Function names can only include alphanumeric...
```

**Same signature as Case 05's Finding 2:** Upstage's streamed responses drop
the `function.name`. Case 05 worked around it (open source, added
`OPENWIKI_DISABLE_STREAMING`). **Grok Build is closed-source** — no client-side
workaround possible. This stays a hard blocker.

</v-click>

<v-click>

### Three methods (no tools involved)

| Method | Command | What it proves |
|---|---|---|
| **A** | `grok -p "Reply with exactly: grok-solar-ready" -m solar-open2` | Exact-string round trip |
| **B** | `grok -p "Explain why sum 1..50 = 1275" -m solar-open2` | Reasoning — must return `1275` |
| **C** | `grok -p "Write is_prime(n) in Python" -m solar-open2` | Coding task — must contain `def is_prime` |

</v-click>

<v-click>

### Verified results

| Method | Result |
|---|---|
| A — single-turn | `grok-solar-ready` |
| B — reasoning | Correctly derived `1275` (Gauss formula + pairing method) |
| C — coding | Working `is_prime(n)` with docstring |
| Finding — tool-calling | Reproducibly fails: `Invalid function name: ''` |

</v-click>

<!--
Case 06 is an "Extend" case: it tests Grok Build (xAI's new terminal coding agent)
against Solar Open 2 as a custom model. The `api_backend` flexibility is a real
advantage over Codex. The tool-calling bug is the same root cause as Case 05, but
here there's no workaround — honest documentation of a limitation.
-->
