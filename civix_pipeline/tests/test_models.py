from __future__ import annotations

import json
from pathlib import Path

import jsonschema
import pytest

from civix.models import Brief, Story

SCHEMA_PATH = Path(__file__).resolve().parent.parent.parent / "schema" / "brief.schema.json"
FIXTURES_DIR = Path(__file__).resolve().parent.parent.parent / "fixtures"


@pytest.fixture
def schema() -> dict:
    return json.loads(SCHEMA_PATH.read_text())


@pytest.mark.parametrize("fixture_name", ["2026-09-01.json", "2026-08-31.json"])
def test_hand_written_fixtures_round_trip_through_pydantic_and_schema(
    fixture_name: str, schema: dict
) -> None:
    """The two hand-written fixture briefs must parse into pydantic models
    and, once re-serialized, still validate against the JSON schema —
    this is the seam test between the pipeline's models and the app's
    wire contract.
    """
    raw = json.loads((FIXTURES_DIR / fixture_name).read_text())

    brief = Brief.model_validate(raw)
    assert brief.brief_id == raw["brief_id"]
    assert len(brief.stories) == len(raw["stories"])

    # exclude_none: unset Optional fields (review, citation.cited_text)
    # must be absent from the wire format, not emitted as null — the
    # schema requires them typed when present. See civix/publish.py's
    # matching exclude_none=True.
    round_tripped = json.loads(brief.model_dump_json(by_alias=True, exclude_none=True))
    jsonschema.validate(round_tripped, schema)


def test_check_rejects_out_of_range_answer_index() -> None:
    with pytest.raises(ValueError):
        Story.model_validate(
            {
                "id": "x",
                "headline": "x",
                "topics": ["economy"],
                "what_happened": {
                    "text": "x",
                    "citations": [{"label": "l", "url": "https://x"}],
                },
                "why_it_matters": {
                    "text": "x",
                    "citations": [{"label": "l", "url": "https://x"}],
                },
                "argument": {
                    "side_a": {"label": "a", "text": "x", "word_count": 1},
                    "side_b": {"label": "b", "text": "x", "word_count": 1},
                },
                "check": {
                    "question": "q",
                    "options": ["a", "b"],
                    "answer_index": 5,  # out of range for 2 options
                    "explanation": "e",
                },
            }
        )
