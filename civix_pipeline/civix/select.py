"""Stage 2 — select which candidate primary-source items become tonight's
five stories.

Selection is where bias actually enters the pipeline — *which* stories run
is itself editorial, even if each one is written neutrally. This module
keeps that judgment call visible and auditable rather than implicit:
every candidate is scored against a fixed rubric, and `balance_report()`
gives a rolling view of what's actually been covered so skew shows up in
a report instead of only in a reader's gut feeling.
"""
from __future__ import annotations

import json
from collections import Counter
from dataclasses import dataclass
from datetime import date, timedelta
from pathlib import Path

PUBLISHED_DIR = Path(__file__).resolve().parent.parent / "data" / "published"


@dataclass
class Candidate:
    """One primary-source item pulled from ingest, before drafting."""

    id: str
    source_label: str
    source_url: str
    source_text: str
    topics: list[str]
    summary: str  # one-line human summary used only for ranking, never published

    # Rubric inputs — see score() for how these combine.
    magnitude: int  # 1-5: how consequential is this change
    concreteness: int  # 1-5: is this a thing that happened (vote, ruling, filing)
                        # vs. still-developing rhetoric
    teen_relevance: int  # 1-5: how directly does this touch a teen's concrete life


def score(candidate: Candidate) -> float:
    """Weighted rubric score. Concreteness is weighted highest on purpose —
    "a thing that verifiably happened" is the whole premise of the app;
    it should out-rank a more dramatic but murkier story.
    """
    return (
        candidate.magnitude * 1.0
        + candidate.concreteness * 1.5
        + candidate.teen_relevance * 1.2
    )


def already_covered(candidate_id: str, lookback_days: int = 30) -> bool:
    """True if this candidate (by id) already ran in a recent published brief."""
    cutoff = date.today() - timedelta(days=lookback_days)
    for path in PUBLISHED_DIR.glob("*.json"):
        try:
            brief_date = date.fromisoformat(path.stem)
        except ValueError:
            continue
        if brief_date < cutoff:
            continue
        brief = json.loads(path.read_text())
        if any(story["id"] == candidate_id for story in brief.get("stories", [])):
            return True
    return False


def select_top_n(candidates: list[Candidate], n: int = 5) -> list[Candidate]:
    fresh = [c for c in candidates if not already_covered(c.id)]
    return sorted(fresh, key=score, reverse=True)[:n]


def balance_report(lookback_days: int = 30) -> dict:
    """Topic-frequency breakdown of everything published in the lookback
    window. Not a pass/fail gate — a number to look at before the next
    night's selection, the way the plan intends: 'you can't fix what you
    don't measure.'
    """
    cutoff = date.today() - timedelta(days=lookback_days)
    topic_counts: Counter[str] = Counter()
    stories_counted = 0

    for path in PUBLISHED_DIR.glob("*.json"):
        try:
            brief_date = date.fromisoformat(path.stem)
        except ValueError:
            continue
        if brief_date < cutoff:
            continue
        brief = json.loads(path.read_text())
        for story in brief.get("stories", []):
            stories_counted += 1
            topic_counts.update(story.get("topics", []))

    return {
        "window_days": lookback_days,
        "stories_counted": stories_counted,
        "topic_counts": dict(topic_counts.most_common()),
    }
