<!-- slidev:enable-auto-animate -->
# Case 01 — Solar Open 2 × Claude Code

## Three ways to route Claude Code through Solar Open 2

<v-click>

### Case 01A — Official CLI (plain env vars)

- `ANTHROPIC_BASE_URL="https://api.upstage.ai"`
- Map every model slot: `ANTHROPIC_DEFAULT_SONNET_MODEL`, `ANTHROPIC_DEFAULT_FABLE_MODEL`, `CLAUDE_CODE_SUBAGENT_MODEL`, …
- **No fork, no patch, no proxy**

### Case 01B — `claude-upstage` wrapper

- Upstage's convenience script sets env vars via `set_claude_env`, then `exec`s stock `claude`
- Same exact binary as 01A — just a thinner wrapper
- **Known limitation:** doesn't pass `-p` through; pipe via stdin instead

### Case 01C — `jyje/claude-docker`

- Community Docker image (`ghcr.io/jyje/claude-docker`) with `claude` at entrypoint
- Same `ANTHROPIC_*` env var recipe as 01A, passed through `docker run -e`

</v-click>

<v-click>

## Key Findings

</v-click>

<v-click>

### 🎯 Skill invocation: explicit beats autonomous

- Without naming the skill: Solar Open 2 **silently drops** the required `gitmoji + type(domain):` format
- With explicit skill name: correct every time — picks up the contract precisely
- **Takeaway:** when running Claude Code on Solar Open 2, name the skill explicitly

</v-click>

<v-click>

### 🔧 Subagents stay on Solar Open 2

- `CLAUDE_CODE_SUBAGENT_MODEL="solar-open2"` keeps Explore/Task-tool calls on the right model
- Verified: subagent listed real files in the directory — not hallucinated

</v-click>

<!--
Case 01 proves the Claude Code harness works on Solar Open 2 via three independent paths:
plain env vars (the authoritative setup), the convenience wrapper, and Docker isolation.
The skill-subagent finding is a real, actionable gap — not a bug, but a behavioral difference
from Claude models that users need to know about.
-->
