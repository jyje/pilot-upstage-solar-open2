"""Unit tests for demo.py's pure logic. The live SDK methods (A/B/C) call
Solar Open 2 over the network and are exercised end-to-end by
scripts/verify.sh instead, not here."""

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
