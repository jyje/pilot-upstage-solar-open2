<!-- slidev:enable-auto-animate -->
# Case 05 — Solar Open 2 × LangChain OpenWiki

## Self-documenting the repo with openwiki

<v-click>

### How it works

`openwiki` builds and maintains an agent-readable wiki for a codebase.
Target: **this repo itself** — document its latest commit, answer questions about it.

To keep the real root untouched, the verify script shallow-clones into a
gitignored `scratch/` directory and runs `openwiki` there.

</v-click>

<v-click>

### Finding 1: `anthropic` provider can't reach Solar Open 2

`openwiki`'s `anthropic` provider uses only `apiKey` (→ `x-api-key` header).
Upstage's Anthropic-compatible endpoint **rejects `x-api-key` with 401**.

**Workaround:** generic `openai-compatible` provider (Bearer-authenticated):

```bash
OPENWIKI_PROVIDER=openai-compatible
OPENAI_COMPATIBLE_BASE_URL=https://api.upstage.ai/v1/solar
OPENWIKI_MODEL_ID=solar-open2
```

</v-click>

<v-click>

### Finding 2: Streaming drops the tool call function name

Every tool-using run failed with `400 Invalid function name: ''`.

Root cause traced via a local logging proxy:
- Request sent all 16 tools correctly named
- **Streamed response** came back with `function.name` = `""` (empty)
- `stream: false` 응답엔 올바른 이름(`"ls"`)이 포함됨
- **Only streamed responses are affected** — an Upstage/Solar Open 2 bug

**Workaround:** patched fork with `OPENWIKI_DISABLE_STREAMING=true`
(opt-in escape hatch, doesn't affect other providers)

</v-click>

<v-click>

### Finding 3: Full doc gen exceeds default rate limit

`openwiki code --update` sends a ~57KB system prompt per turn and needs
multiple tool-calling round trips — enough to exceed the **50,000 tokens/min**
rate limit in a single run. Capacity constraint, not a code bug.

</v-click>

<v-click>

### Verified: 3 Q&A questions

1. **"What is this repository about?"** — identifies 5 cases, Solar Open 2 specs
2. **"What did the most recent commit change?"** — commit hash, message, intent, co-authors
3. **"How many cases, what does each demonstrate?"** — structured table of all cases

</v-click>

<!--
Case 05 is an "Extend" case: it uses openwiki to self-document the repo itself.
The three findings are real, distinct issues uncovered during verification — each
with a concrete workaround or explanation. The streaming bug (Finding 2) is the
same root cause that blocks Case 06's tool-calling.
-->
