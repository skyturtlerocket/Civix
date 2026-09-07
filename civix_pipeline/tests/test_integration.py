"""Live-API tests — the ones that need a real Claude call.

Skipped automatically unless ANTHROPIC_API_KEY (or another credential
source `ant auth status` recognizes) is available, so `pytest` stays fast
and free by default. Run explicitly with:

    ANTHROPIC_API_KEY=... pytest tests/test_integration.py -v
"""
from __future__ import annotations

import os

import pytest

from civix.critique import blind_swap_test
from civix.models import Argument, ArgumentSide

pytestmark = pytest.mark.skipif(
    not os.environ.get("ANTHROPIC_API_KEY"),
    reason="requires a live Claude API credential",
)


def test_blind_swap_catches_a_knowingly_slanted_pair() -> None:
    """One side written as a careful, evidenced case; the other written as
    a weak strawman on purpose. The blind swap test should catch the
    imbalance even though both texts are the same rough length (so the
    parity gate alone wouldn't catch this).
    """
    strong = (
        "Supporters argue the pilot's two-year sunset lets the city measure "
        "the actual effect on attendance and ridership before committing "
        "to a permanent budget line, and that the cost is modest relative "
        "to the district's total transportation spending."
    )
    weak = (
        "Opponents argue this and think it is not a good idea for some "
        "reasons that are honestly kind of vague and not very well "
        "explained, mostly just a general feeling that it seems wrong "
        "somehow without much backing it up."
    )
    argument = Argument(
        side_a=ArgumentSide(label="Supporters argue", text=strong, word_count=len(strong.split())),
        side_b=ArgumentSide(label="Opponents argue", text=weak, word_count=len(weak.split())),
    )
    result = blind_swap_test(argument)
    assert not result.passed
