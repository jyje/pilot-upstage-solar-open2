"""Unit tests for demo.py's pure logic and mocked SDK response handling."""

import asyncio
from collections.abc import AsyncIterator
from typing import Self

import pytest

import demo
from demo import truncate


def test_truncate_short_text_passes_through() -> None:
    assert truncate("hello") == "  hello"


def test_truncate_collapses_whitespace() -> None:
    assert truncate("hello\n\n  world") == "  hello world"


def test_truncate_long_text_is_cut_with_marker() -> None:
    text = "x" * 150
    result = truncate(text, limit=100, width=100)
    assert result == ("  " + "x" * 100) + "\n  ...(truncated)"


def test_truncate_exactly_at_limit_is_not_marked() -> None:
    text = "x" * 100
    assert truncate(text, limit=100, width=100) == "  " + text


def test_truncate_wraps_long_text_across_multiple_lines() -> None:
    text = "word " * 130
    result = truncate(text)
    assert "...(truncated)" not in result
    assert result.count("\n") >= 9


class FakeTextBlock:
    def __init__(self, text: str) -> None:
        self.text = text


class FakeAssistantMessage:
    def __init__(self, content: list[object]) -> None:
        self.content = content


class FakeClient:
    def __init__(self, responses: list[list[object]]) -> None:
        self.responses = iter(responses)

    async def __aenter__(self) -> Self:
        return self

    async def __aexit__(self, *_: object) -> None:
        return None

    async def query(self, _prompt: str) -> None:
        return None

    async def receive_response(self) -> AsyncIterator[object]:
        for message in next(self.responses):
            yield message


def patch_session_client(
    monkeypatch: pytest.MonkeyPatch, responses: list[list[object]]
) -> None:
    monkeypatch.setattr(demo, "solar_options", lambda: object())
    monkeypatch.setattr(
        demo, "ClaudeSDKClient", lambda **_kwargs: FakeClient(responses)
    )
    monkeypatch.setattr(demo, "AssistantMessage", FakeAssistantMessage)
    monkeypatch.setattr(demo, "TextBlock", FakeTextBlock)


def test_session_memory_returns_assistant_text(
    monkeypatch: pytest.MonkeyPatch,
) -> None:
    patch_session_client(
        monkeypatch,
        [[], [FakeAssistantMessage([FakeTextBlock("42")])]],
    )

    assert asyncio.run(demo.method_b_session_memory()) == "42"


@pytest.mark.parametrize("second_response", [[], [object()]])
def test_session_memory_raises_when_second_turn_has_no_assistant_text(
    monkeypatch: pytest.MonkeyPatch, second_response: list[object]
) -> None:
    patch_session_client(monkeypatch, [[], second_response])

    with pytest.raises(RuntimeError, match="returned no assistant text"):
        asyncio.run(demo.method_b_session_memory())
