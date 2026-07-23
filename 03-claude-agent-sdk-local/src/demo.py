"""Drive a local Claude Code instance programmatically via claude-agent-sdk,
against Upstage's Solar Open 2 model (same env var recipe verified in
01-solar-open2-harness).

Three methods, each proving a distinct SDK capability:
  A. query()            - one-shot call, structured message types
  B. ClaudeSDKClient     - multi-turn session, context retained across turns
  C. query() + tool use  - a ToolUseBlock surfaces in the structured stream,
                           not just as text to scrape
"""

import asyncio
import os
import sys

from claude_agent_sdk import (
    AssistantMessage,
    ClaudeAgentOptions,
    ClaudeSDKClient,
    TextBlock,
    ToolUseBlock,
    query,
)

SOLAR_MODEL = os.environ.get("SOLAR_MODEL", "solar-open2")
SOLAR_BASE_URL = "https://api.upstage.ai"


def solar_options(cwd: str | None = None) -> ClaudeAgentOptions:
    """Same Solar Open 2 recipe verified in topic 01: ANTHROPIC_AUTH_TOKEN,
    not ANTHROPIC_API_KEY (the SDK docs' own example hangs against Upstage)."""
    env = {
        "ANTHROPIC_BASE_URL": SOLAR_BASE_URL,
        "ANTHROPIC_AUTH_TOKEN": os.environ["UPSTAGE_API_KEY"],
    }
    return ClaudeAgentOptions(model=SOLAR_MODEL, env=env, cwd=cwd)


def truncate(text: str, limit: int = 100) -> str:
    """Collapse whitespace and cap at `limit` chars, mirroring topic 01's
    shell preview() so both topics report evidence the same way."""
    collapsed = " ".join(text.split())
    if len(collapsed) > limit:
        return f"{collapsed[:limit]} ...(truncated)"
    return collapsed


async def method_a_query() -> str:
    """One-shot query(): collect the distinct structured message types
    received, return the final reply."""
    reply = ""
    seen_types: set[str] = set()
    async for message in query(prompt="hello", options=solar_options()):
        seen_types.add(type(message).__name__)
        if isinstance(message, AssistantMessage):
            for block in message.content:
                if isinstance(block, TextBlock):
                    reply = block.text
    print(f"  message types seen: {', '.join(sorted(seen_types))}")
    return reply


async def method_b_session_memory() -> str:
    """ClaudeSDKClient multi-turn session: a number told in turn 1 must
    come back in turn 2, proving the session retains context."""
    async with ClaudeSDKClient(options=solar_options()) as client:
        await client.query("Remember the number 42. Reply with just OK.")
        async for _ in client.receive_response():
            pass

        await client.query(
            "What number did I just ask you to remember? Reply with just the number."
        )
        reply = ""
        async for message in client.receive_response():
            if isinstance(message, AssistantMessage):
                for block in message.content:
                    if isinstance(block, TextBlock):
                        reply = block.text
        return reply


async def method_c_tool_use() -> bool:
    """Ask for a tool-driven file listing; assert a ToolUseBlock actually
    appears in the structured stream (programmatic proof, not a text match)."""
    saw_tool_use = False
    prompt = "Use a tool to list the files in the current directory. Do not guess."
    async for message in query(prompt=prompt, options=solar_options(cwd=os.getcwd())):
        if isinstance(message, AssistantMessage):
            for block in message.content:
                if isinstance(block, ToolUseBlock):
                    saw_tool_use = True
    return saw_tool_use


async def _main() -> int:
    print("== Method A: query() one-shot call, structured message types ==")
    try:
        a_reply = await method_a_query()
    except Exception as exc:  # noqa: BLE001 - report cleanly, not a raw trace
        print(f"FAIL: Method A raised {type(exc).__name__}: {exc}", file=sys.stderr)
        return 1
    print(f"  -> {truncate(a_reply)}")
    if not a_reply:
        print("FAIL: Method A got no reply", file=sys.stderr)
        return 1
    print("PASS: Method A got a structured reply.")

    print()
    print("== Method B: ClaudeSDKClient multi-turn session memory ==")
    try:
        b_reply = await method_b_session_memory()
    except Exception as exc:  # noqa: BLE001
        print(f"FAIL: Method B raised {type(exc).__name__}: {exc}", file=sys.stderr)
        return 1
    print(f"  -> {truncate(b_reply)}")
    if "42" not in b_reply:
        print(f"FAIL: Method B didn't recall 42: {b_reply}", file=sys.stderr)
        return 1
    print("PASS: Method B recalled context across turns.")

    print()
    print("== Method C: query() + tool use, ToolUseBlock visibility ==")
    try:
        c_saw_tool_use = await method_c_tool_use()
    except Exception as exc:  # noqa: BLE001
        print(f"FAIL: Method C raised {type(exc).__name__}: {exc}", file=sys.stderr)
        return 1
    print(f"  -> saw_tool_use={c_saw_tool_use}")
    if not c_saw_tool_use:
        print("FAIL: Method C saw no ToolUseBlock", file=sys.stderr)
        return 1
    print("PASS: Method C's tool use surfaced in the structured stream.")

    print()
    print("All checks passed.")
    return 0


def main() -> None:
    sys.exit(asyncio.run(_main()))


if __name__ == "__main__":
    main()
