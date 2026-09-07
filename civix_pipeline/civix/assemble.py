"""Ties Stages 2-4 together: take one selected candidate, draft it, gate
it, critique it, and write the result to data/drafts/ for human review.

This is the function the nightly job calls once per selected story. It
never publishes anything itself — see civix/publish.py for that, which
only ever reads from data/approved/.
"""
from __future__ import annotations

import json
from dataclasses import dataclass
from pathlib import Path

from civix.checks import GateReport, run_gates
from civix.critique import BlindSwapResult, FairnessCritique, blind_swap_test, two_sided_critique
from civix.draft import (
    draft_argument_side,
    draft_check,
    draft_what_happened,
    draft_why_it_matters,
)
from civix.ingest.base import RawSource
from civix.models import Argument, Story

DRAFTS_DIR = Path(__file__).resolve().parent.parent / "data" / "drafts"


@dataclass
class DraftPackage:
    """Everything a reviewer needs to see for one story: the draft itself,
    plus every automated signal produced while making it.
    """

    story: Story
    gates: GateReport
    swap_test: BlindSwapResult
    critiques: dict[str, FairnessCritique]

    def to_review_json(self) -> dict:
        return {
            "story": json.loads(self.story.model_dump_json()),
            "gates": json.loads(self.gates.model_dump_json()),
            "swap_test": json.loads(self.swap_test.model_dump_json()),
            "critiques": {
                k: json.loads(v.model_dump_json()) for k, v in self.critiques.items()
            },
        }


def assemble_story(source: RawSource, headline: str, topics: list[str]) -> DraftPackage:
    what_happened = draft_what_happened(source.label, source.url, source.text)
    why_it_matters = draft_why_it_matters(
        source.label, source.url, source.text, what_happened.text
    )

    # Independent, mutually-blind calls — see prompts/steelman.md.
    side_a = draft_argument_side(
        source.label, source.text, what_happened.text, side="supporters"
    )
    side_b = draft_argument_side(
        source.label, source.text, what_happened.text, side="opponents"
    )
    argument = Argument(side_a=side_a, side_b=side_b)

    check = draft_check(
        headline=headline,
        what_happened_text=what_happened.text,
        why_it_matters_text=why_it_matters.text,
        side_a_text=side_a.text,
        side_b_text=side_b.text,
    )

    story = Story(
        id=source.id,
        headline=headline,
        topics=topics,
        what_happened=what_happened,
        why_it_matters=why_it_matters,
        argument=argument,
        check=check,
    )

    gates = run_gates(story, source_documents={source.label: source.text})
    swap_test = blind_swap_test(argument)
    critiques = two_sided_critique(argument)

    return DraftPackage(story=story, gates=gates, swap_test=swap_test, critiques=critiques)


def save_draft(package: DraftPackage) -> Path:
    DRAFTS_DIR.mkdir(parents=True, exist_ok=True)
    path = DRAFTS_DIR / f"{package.story.id}.json"
    path.write_text(json.dumps(package.to_review_json(), indent=2, default=str))
    return path
