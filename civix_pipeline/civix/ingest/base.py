"""Shared shape for everything ingest/* fetches, regardless of source.

Every ingest module (congress.py, federal_register.py, courts.py) turns a
government source into one of these — the common currency select.py and
draft.py operate on, so the rest of the pipeline doesn't need to know
which agency's API a given story came from.
"""
from __future__ import annotations

from dataclasses import dataclass


@dataclass
class RawSource:
    id: str  # stable id, becomes the story id downstream (e.g. "hr1234-passage")
    label: str  # human-readable citation label, e.g. "H.R. 1234 Roll Call Vote"
    url: str  # canonical link a reader can click through to
    text: str  # the primary-source text passed to Claude as a document block
    topics: list[str]
    summary: str  # one-line summary used only for select.py's ranking
