"""Word-parity gate for the two-sided argument panel.

The UI renders both sides in identically-sized boxes (see civix_app's
argument-panel golden test) — that visual symmetry is a bias control, and
it only means something if the underlying word counts are actually close.
"""
from __future__ import annotations

from pydantic import BaseModel

from civix.models import Argument

MAX_IMBALANCE = 0.10  # ±10%, per the plan


class ParityResult(BaseModel):
    passed: bool
    side_a_words: int
    side_b_words: int
    imbalance: float  # fraction, e.g. 0.14 for 14% difference
    reason: str | None = None


def _word_count(text: str) -> int:
    return len(text.split())


def check_parity(argument: Argument) -> ParityResult:
    """Reject if the two sides differ in length by more than MAX_IMBALANCE,
    or if a side's declared ``word_count`` doesn't match its actual text
    (catches a drafting call that miscounted or a hand-edit that wasn't
    re-counted before republishing).
    """
    a_actual = _word_count(argument.side_a.text)
    b_actual = _word_count(argument.side_b.text)

    if argument.side_a.word_count != a_actual:
        return ParityResult(
            passed=False,
            side_a_words=a_actual,
            side_b_words=b_actual,
            imbalance=0.0,
            reason=(
                f"side_a.word_count ({argument.side_a.word_count}) does not "
                f"match actual word count ({a_actual})"
            ),
        )
    if argument.side_b.word_count != b_actual:
        return ParityResult(
            passed=False,
            side_a_words=a_actual,
            side_b_words=b_actual,
            imbalance=0.0,
            reason=(
                f"side_b.word_count ({argument.side_b.word_count}) does not "
                f"match actual word count ({b_actual})"
            ),
        )

    longer = max(a_actual, b_actual)
    shorter = min(a_actual, b_actual)
    imbalance = (longer - shorter) / longer if longer else 0.0
    passed = imbalance <= MAX_IMBALANCE

    return ParityResult(
        passed=passed,
        side_a_words=a_actual,
        side_b_words=b_actual,
        imbalance=round(imbalance, 4),
        reason=None if passed else f"imbalance {imbalance:.0%} exceeds {MAX_IMBALANCE:.0%}",
    )
