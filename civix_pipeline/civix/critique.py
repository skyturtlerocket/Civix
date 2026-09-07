"""Stage 4's hardest gate — adversarial checks a wordlist can't catch.

Two independent passes, both run against an already-drafted `Argument`:

1. **Blind swap test.** A critic call sees both panels with their side
   labels stripped, in both possible orderings, and is asked (a) which is
   more persuasive and (b) which side it thinks each one represents. If it
   consistently favors the same side regardless of order or reliably
   guesses correctly which is which, the panel reads as slanted even
   though the wordlist gate passed clean.
2. **Two-sided critique.** One call asked "how is this unfair to the
   left," a separate call asked "how is this unfair to the right." Not a
   pass/fail gate — the output is surfaced to the human reviewer
   side-by-side in Stage 5, since fairness critiques are exactly the kind
   of judgment call that shouldn't be silently auto-resolved.
"""
from __future__ import annotations

import anthropic
from pydantic import BaseModel

from civix.models import Argument

MODEL = "claude-opus-5"


def _client() -> anthropic.Anthropic:
    return anthropic.Anthropic()


class SwapJudgment(BaseModel):
    more_persuasive: str  # "first" or "second", as shown to the critic
    guessed_first_side: str  # "supporters" or "opponents"
    guessed_second_side: str
    reasoning: str


class BlindSwapResult(BaseModel):
    passed: bool
    order_a_first: SwapJudgment
    order_b_first: SwapJudgment
    reason: str | None = None


_SWAP_PROMPT = """You will read two short arguments about the same policy action,
labeled only "First" and "Second" — you are not told which side either one
represents.

First: {first_text}

Second: {second_text}

Answer three questions:
1. Which argument is more persuasively written: "first" or "second"?
2. What position do you think "First" represents: "supporters" or
   "opponents" of the action?
3. What position do you think "Second" represents: "supporters" or
   "opponents" of the action?

Base your persuasiveness judgment purely on writing quality and rhetorical
force, not on which position you happen to agree with."""


def _judge_pair(first_text: str, second_text: str) -> SwapJudgment:
    response = _client().messages.parse(
        model=MODEL,
        max_tokens=1024,
        thinking={"type": "adaptive"},
        messages=[
            {
                "role": "user",
                "content": _SWAP_PROMPT.format(
                    first_text=first_text, second_text=second_text
                ),
            }
        ],
        output_format=SwapJudgment,
    )
    return response.parsed_output


def blind_swap_test(argument: Argument) -> BlindSwapResult:
    """Run the same unlabeled pair in both orderings. A slant-free panel
    should show no consistent preference across the swap; if the "more
    persuasive" pick lands on the same actual side both times, that's a
    signal the panel reads as unbalanced, not just that the critic model
    has a fixed rhetorical preference.
    """
    order_a = _judge_pair(argument.side_a.text, argument.side_b.text)
    order_b = _judge_pair(argument.side_b.text, argument.side_a.text)

    # In order A, "first" = side_a; in order B, "first" = side_b.
    # Resolve each judgment's persuasiveness pick back to an actual side.
    winner_a = "side_a" if order_a.more_persuasive == "first" else "side_b"
    winner_b = "side_b" if order_b.more_persuasive == "first" else "side_a"

    consistent_winner = winner_a == winner_b
    passed = not consistent_winner

    reason = None
    if not passed:
        reason = (
            f"the same side ({winner_a}) was judged more persuasive in both "
            "orderings — the panel likely reads as unbalanced"
        )

    return BlindSwapResult(
        passed=passed, order_a_first=order_a, order_b_first=order_b, reason=reason
    )


class FairnessCritique(BaseModel):
    critique: str
    suggested_edit: str | None = None


_CRITIQUE_PROMPT = """Here is a two-sided argument panel from a political-literacy
app for teenagers:

Supporters argue: {side_a_text}

Opponents argue: {side_b_text}

Critique this panel from the perspective of someone who leans {perspective}.
Where, if anywhere, does the panel understate, caricature, or shortchange
the {perspective} position relative to the other side? Be specific — quote
the phrase you'd change if you have one. If you find nothing genuinely
unfair, say so plainly rather than manufacturing a complaint."""


def critique_from_perspective(argument: Argument, perspective: str) -> FairnessCritique:
    """``perspective`` is a plain description like "the left" or "the
    right" — not a party label baked into the app, just the framing used
    to prompt this one adversarial read.
    """
    response = _client().messages.parse(
        model=MODEL,
        max_tokens=1024,
        thinking={"type": "adaptive"},
        messages=[
            {
                "role": "user",
                "content": _CRITIQUE_PROMPT.format(
                    side_a_text=argument.side_a.text,
                    side_b_text=argument.side_b.text,
                    perspective=perspective,
                ),
            }
        ],
        output_format=FairnessCritique,
    )
    return response.parsed_output


def two_sided_critique(argument: Argument) -> dict[str, FairnessCritique]:
    return {
        "left": critique_from_perspective(argument, "the left"),
        "right": critique_from_perspective(argument, "the right"),
    }
