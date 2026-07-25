<!-- slidev:enable-auto-animate -->
# Cross-Cutting Learnings

## Patterns that emerged across all 7 cases

<v-click>

### 🔑 Authentication: Bearer, not x-api-key

Upstage's Anthropic-compatible endpoint **rejects `x-api-key`** with 401.

Required: `Authorization: Bearer <key>` via `ANTHROPIC_AUTH_TOKEN`.

| Context | What to set |
|---|---|
| Claude Code CLI / SDK | `ANTHROPIC_AUTH_TOKEN` |
| LangChain `ChatAnthropic` | ❌ Don't use — it sends `x-api-key` |
| LangChain `ChatOpenAI` / `ChatUpstage` | ✅ `OPENAI_COMPATIBLE_API_KEY` (Bearer) |
| Grok Build / Hermes Agent | `UPSTAGE_API_KEY` → Bearer via provider |

</v-click>

<v-click>

### 🐛 Streaming bug: tool call function names dropped

Upstage's **streamed** Chat Completions responses return `function.name = ""`
for tool calls. Non-streamed responses are correct.

Affected cases: **05** (openwiki — patched with `OPENWIKI_DISABLE_STREAMING`),
**06** (Grok Build — no workaround, closed-source).

</v-click>

<v-click>

### 🐍 Python 3.14 ecosystem gap

`langchain-upstage` depends on `tokenizers` — no `cp314` wheel exists.
Source build fails with a real `cargo`/PyO3 compile error.

**All Python cases pin to 3.13** until an upstream wheel ships.

</v-click>

<v-click>

### 🎯 Skill / tool invocation: explicit beats autonomous

Solar Open 2 follows a skill's contract precisely **when explicitly told to load it**.
But it doesn't reliably decide on its own that a skill applies from trigger phrases alone.

**Takeaway:** name the skill explicitly in prompts.

</v-click>

<v-click>

### 🌐 Two wire paths to the same model

| Wire path | Endpoint | Used by |
|---|---|---|
| **Anthropic Messages API** (compat layer) | `https://api.upstage.ai` | Case 01, Case 03 |
| **OpenAI Chat Completions** (native) | `https://api.upstage.ai/v1/solar` | Case 04, Case 05, Case 06, Case 07 |

Both reach Solar Open 2. The OpenAI path avoids the `ANTHROPIC_AUTH_TOKEN` dance.

</v-click>

<!--
These are the patterns that surfaced across multiple cases — not from any single
experiment, but from the cumulative evidence of running Solar Open 2 through 7
different harness configurations. Each one is actionable for anyone building on
Solar Open 2 today.
-->
