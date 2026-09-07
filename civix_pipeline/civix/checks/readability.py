"""Readability gate — target roughly 8th-grade reading level.

Uses textstat's Flesch-Kincaid grade level. This is advisory-strict: it
blocks drafts that are clearly too dense, but a couple of grades either
side of the target is normal for text this short (Flesch-Kincaid is noisy
on short passages), so the tolerance is wide on purpose.
"""
from __future__ import annotations

import textstat
from pydantic import BaseModel

TARGET_GRADE = 8.0
TOLERANCE = 3.0  # allow grades 5-11 before failing


class ReadabilityResult(BaseModel):
    passed: bool
    grade_level: float
    reason: str | None = None


def check_readability(text: str) -> ReadabilityResult:
    grade = textstat.flesch_kincaid_grade(text)
    passed = abs(grade - TARGET_GRADE) <= TOLERANCE
    reason = None
    if not passed:
        reason = (
            f"Flesch-Kincaid grade {grade:.1f} is more than {TOLERANCE:.0f} "
            f"grades from the {TARGET_GRADE:.0f}-grade target"
        )
    return ReadabilityResult(passed=passed, grade_level=round(grade, 2), reason=reason)
