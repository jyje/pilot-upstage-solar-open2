<!-- slidev:enable-auto-animate -->
# Case 03 — Solar Open 2 × Claude Agent SDK

## Drive Claude Code programmatically from Python

<v-click>

### How it works

`claude-agent-sdk` drives the same `claude` CLI binary as a subprocess.
The **exact same Solar Open 2 env var recipe** from Case 01 applies —
just passed through `ClaudeAgentOptions(env={...})` instead of shell `export`.

```python
from claude_agent_sdk import ClaudeAgentOptions

options = ClaudeAgentOptions(
    model="solar-open2",
    env={
        "ANTHROPIC_BASE_URL": "https://api.upstage.ai",
        "ANTHROPIC_AUTH_TOKEN": upstage_api_key,
    },
)
```

</v-click>

<v-click>

### Finding: SDK docs example doesn't work against Upstage

The SDK docs show `env={"ANTHROPIC_API_KEY": ...}` — that **hangs** against Upstage.

Swapping in `ANTHROPIC_AUTH_TOKEN` (Bearer) works immediately.
Same root cause as Case 01's finding: Upstage's Anthropic-compatible endpoint
rejects `x-api-key`, requires `Authorization: Bearer`.

</v-click>

<v-click>

### Two entry points, three methods

| Method | API | What it proves |
|---|---|---|
| **A** | `query()` | Structured message types (`AssistantMessage`, `ToolUseBlock`, …) — not stdout scraping |
| **B** | `ClaudeSDKClient` | Session memory across turns — turn 2 must recall "42" from turn 1 |
| **C** | `query()` + tool visibility | A real `ToolUseBlock` appears in the message stream — programmatic proof of tool invocation |

</v-click>

<v-click>

### Verified results

| Method | Result |
|---|---|
| A — `query()` | `AssistantMessage`, `ResultMessage`, `SystemMessage` — correct types |
| B — session memory | `42` recalled correctly in turn 2 |
| C — tool visibility | `saw_tool_use=True` — real `ToolUseBlock` in stream |

</v-click>

<!--
Case 03 is an "Extend" case: it shows what the official Python SDK buys over
Case 01's raw CLI approach — typed message objects instead of text scraping,
session memory across turns, and programmatic tool-call visibility.
The ANTHROPIC_AUTH_TOKEN finding mirrors Case 01's, seen from the SDK side.
-->
