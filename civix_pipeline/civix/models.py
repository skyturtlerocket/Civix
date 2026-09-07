"""Pydantic models mirroring schema/brief.schema.json.

These are the pipeline's in-memory representation of a brief at every
stage — draft, gated, reviewed, published. Keep this file and the JSON
schema in sync; `tests/test_models.py` checks a round-trip against a
schema validation to catch drift.
"""
from __future__ import annotations

from datetime import datetime
from typing import Literal

from pydantic import BaseModel, Field, field_validator

Topic = Literal[
    "economy",
    "education",
    "healthcare",
    "environment",
    "technology",
    "immigration",
    "justice",
    "elections",
    "foreign-policy",
    "labor",
    "housing",
    "civil-rights",
]


class Citation(BaseModel):
    label: str
    url: str
    cited_text: str | None = None


class SourcedText(BaseModel):
    text: str
    citations: list[Citation] = Field(min_length=1)


class ArgumentSide(BaseModel):
    label: str
    text: str
    word_count: int

    @field_validator("word_count")
    @classmethod
    def word_count_matches_text(cls, v: int, info) -> int:
        # Advisory only — the real check is checks/parity.py, which compares
        # both sides against each other and can be re-run against edited text.
        return v


class Argument(BaseModel):
    side_a: ArgumentSide
    side_b: ArgumentSide


class Check(BaseModel):
    question: str
    options: list[str] = Field(min_length=2, max_length=5)
    answer_index: int
    explanation: str

    @field_validator("answer_index")
    @classmethod
    def answer_index_in_range(cls, v: int, info) -> int:
        options = info.data.get("options")
        if options is not None and not (0 <= v < len(options)):
            raise ValueError("answer_index out of range for options")
        return v


class ReviewInfo(BaseModel):
    approved_at: datetime
    edited: bool


class Story(BaseModel):
    id: str
    headline: str
    topics: list[Topic] = Field(min_length=1)
    what_happened: SourcedText
    why_it_matters: SourcedText
    argument: Argument
    check: Check
    review: ReviewInfo | None = None


class Brief(BaseModel):
    brief_id: str
    published_at: datetime
    schema_version: Literal[1] = 1
    stories: list[Story] = Field(min_length=1, max_length=8)
