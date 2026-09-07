"""Loaded-language lint.

A wordlist of charged framings that should never appear in "what happened,"
"why it matters," or either argument side. This is a blunt instrument —
it catches obvious slant, not subtle slant — which is exactly why the
blind swap test in civix/critique.py exists as a second, harder-to-game
layer.
"""
from __future__ import annotations

from pydantic import BaseModel

# Deliberately bidirectional — words that flatter either side of a debate
# are just as disqualifying as words that attack it. This list is a
# starting point; extend it as gate failures reveal new patterns.
LOADED_WORDS = frozenset(
    {
        "slammed",
        "blasted",
        "radical",
        "extreme",
        "extremist",
        "handout",
        "invasion",
        "common-sense",
        "commonsense",
        "outrageous",
        "shocking",
        "devastating",
        "disaster",
        "sham",
        "witch hunt",
        "deep state",
        "far-left",
        "far-right",
        "socialist",
        "fascist",
        "un-american",
        "unprecedented",
        "landmark",
        "sweeping",
        "draconian",
        "heroic",
        "brave",
        "courageous",
        "cowardly",
        "corrupt",
        "rigged",
    }
)


class LoadedLanguageResult(BaseModel):
    passed: bool
    hits: list[str]


def check_loaded_language(text: str) -> LoadedLanguageResult:
    """Flag any banned word/phrase found in ``text`` (case-insensitive).

    A plain substring scan rather than word-boundary tokenization — simpler,
    and safe here because every entry is either a full word/hyphenated
    compound or a multi-word phrase unlikely to appear as a false-positive
    substring of an unrelated word.
    """
    lowered = text.lower()
    hits = sorted(word for word in LOADED_WORDS if word in lowered)
    return LoadedLanguageResult(passed=len(hits) == 0, hits=hits)
