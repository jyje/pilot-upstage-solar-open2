<!-- slidev:enable-auto-animate -->
# Case 04 — Solar Open 2 × LangChain DeepAgents

## Pure code-level agent, no Claude CLI involved

<v-click>

### How it works

[`ChatUpstage`](https://pypi.org/project/langchain-upstage/) is a `BaseChatOpenAI`
subclass pointed at Upstage's **OpenAI-compatible** endpoint
(`https://api.upstage.ai/v1/solar`), reading `UPSTAGE_API_KEY` from env automatically.

```python
from langchain_upstage import ChatUpstage
from deepagents import create_deep_agent

model = ChatUpstage(model="solar-open2")
agent = create_deep_agent(model=model, tools=[...], system_prompt="...")
agent.invoke({"messages": [{"role": "user", "content": "..."}]})
```

No `ANTHROPIC_BASE_URL` dance. No `claude` CLI subprocess. LangChain talks to Upstage
directly through Upstage's native OpenAI-compatible endpoint.

</v-click>

<v-click>

### Three methods

| Method | What it proves |
|---|---|
| **A — tool use** | Agent calls a custom `get_weather(city)` tool correctly |
| **B — virtual filesystem** | Agent writes to `deepagents`'s built-in mock filesystem (`/note.txt` → `HELLO-DEEPAGENTS`) |
| **C — subagent delegation** | Main agent delegates arithmetic to a named `math-agent` subagent |

</v-click>

<v-click>

### Finding: Python 3.14 doesn't work (yet)

`langchain-upstage` depends on `tokenizers` (Rust/PyO3). No `cp314` wheel exists
for any release `0.20.3` → `0.23.1`. Source build fails with a real `cargo`/PyO3
compile error — an **upstream ecosystem gap**, not a config workaround.

**This case pins Python 3.13.** Case 03 was moved down to match.

</v-click>

<v-click>

### Verified results

| Method | Result |
|---|---|
| A — tool use | `It's sunny in Seoul!` |
| B — virtual filesystem | `HELLO-DEEPAGENTS` in `result["files"]["/note.txt"]["content"]` |
| C — subagent delegation | `17 + 25 = **42**` from the `math-agent` subagent |

</v-click>

<!--
Case 04 is an "Extend" case: it reaches outside the Claude Code ecosystem entirely
into the LangChain/LangGraph world. The OpenAI-compatible endpoint (vs. Anthropic
Messages API in Case 01/03) is a different wire path to the same Solar Open 2 model.
The Python 3.14 finding is a real ecosystem constraint worth documenting.
-->
