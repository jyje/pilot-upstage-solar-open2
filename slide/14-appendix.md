<!-- slidev:enable-auto-animate -->
# Appendix

## Quick reference for running any case

<v-click>

### Prerequisites (per case)

| Tool | Used by |
|---|---|
| `Node.js 18+` | Case 01, Case 03 |
| `Docker` | Case 01C, Case 02 |
| `Python 3.13` + `uv` | Case 03, Case 04 |
| `kind` + `kubectl` + `helm` | Case 07 |
| `grok` CLI | Case 06 |

All cases require: **`UPSTAGE_API_KEY`** — get one at
<https://console.upstage.ai/api-keys>

</v-click>

<v-click>

### Rate limits (Tier 0)

| Limit | Value |
|---|---|
| Requests/minute | 100 |
| Tokens/minute | 50,000 |

Rolling window. Case 05's full doc generation can exceed the token limit
in a single run — see Finding 3 in that case's README.

</v-click>

<v-click>

### API endpoints reference

| Protocol | Endpoint | Used by |
|---|---|---|
| Anthropic Messages API (compat) | `https://api.upstage.ai` | Case 01, Case 03 |
| OpenAI Chat Completions (native) | `https://api.upstage.ai/v1/solar` | Case 04, Case 05, Case 06, Case 07 |

**Auth:** `Authorization: Bearer <key>` (`ANTHROPIC_AUTH_TOKEN`) — **not**
`x-api-key`.

</v-click>

<v-click>

### Reproduce any case locally

```bash
# Clone the repo
git clone https://github.com/jyje/pilot-upstage-solar-open2
cd pilot-upstage-solar-open2

# Each case is self-contained:
cd 01-solar-open2-harness   # or 02-..., 03-..., etc.

# Read the case-specific REPRODUCE.md for step-by-step setup
cat REPRODUCE.md

# Run the verification script
UPSTAGE_API_KEY="your-key" ./scripts/verify.sh
```

</v-click>

<v-click>

### Glossary

| Term | Meaning |
|---|---|
| **Solar Open 2** | Upstage's 250B-A15B MoE open-weight model, 1M context |
| **`ANTHROPIC_AUTH_TOKEN`** | Bearer token for Upstage's Anthropic-compatible endpoint |
| **`OPENWIKI_DISABLE_STREAMING`** | Opt-in flag to disable streaming (workaround for tool-calling bug) |
| **`api_backend`** | Grok Build config key choosing wire protocol (`chat_completions`, `responses`, `messages`) |
| **`CLAUDE_CODE_SUBAGENT_MODEL`** | Env var ensuring subagent/Task-tool calls stay on Solar Open 2 |

</v-click>

<!--
The appendix is a catch-all for practical reference material that doesn't fit
in the narrative flow of the main slides. It's designed to be useful as a
standalone handout or quick reference during a live demo.
-->
