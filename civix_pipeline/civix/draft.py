"""Stage 3 — draft a story from a primary source with Claude.

Grounding strategy: primary source text is passed as a `document` content
block with `citations: {enabled: true}` (see
https://platform.claude.com/docs/en/build-with-claude/citations). Claude's
response then carries `cited_text` spans that point back into the actual
source — that's what `civix/checks/citations.py` verifies, rather than
trusting a self-reported URL.

Citations are incompatible with `output_config.format` in the same call, so
this module never asks for both in one request: prose passes (what
happened / why it matters / each steelman) get citations, and the one
structured-output pass (the comprehension check) is a separate call over
already-drafted, already-cited text.

The two argument sides are drafted in **separate, independent calls** —
see `prompts/steelman.md` — so neither is written as a rebuttal to the
other.
"""
from __future__ import annotations

from pathlib import Path
from typing import Literal

import anthropic

from civix.models import ArgumentSide, Check, Citation, SourcedText

MODEL = "claude-opus-5"
PROMPTS_DIR = Path(__file__).resolve().parent.parent / "prompts"

_STYLE_GUIDE = (PROMPTS_DIR / "style_guide.md").read_text()


def _client() -> anthropic.Anthropic:
    # Picks up ANTHROPIC_API_KEY / an `ant auth login` profile automatically.
    return anthropic.Anthropic()


def _document_block(source_label: str, source_text: str) -> dict:
    return {
        "type": "document",
        "source": {
            "type": "text",
            "media_type": "text/plain",
            "data": source_text,
        },
        "title": source_label,
        "citations": {"enabled": True},
        # Cached across the ~5 calls that draft one story from this source.
        "cache_control": {"type": "ephemeral"},
    }


def _system_blocks() -> list[dict]:
    return [
        {
            "type": "text",
            "text": _STYLE_GUIDE,
            "cache_control": {"type": "ephemeral"},
        }
    ]


def _extract_text_and_citations(
    response: anthropic.types.Message, source_url: str
) -> tuple[str, list[Citation]]:
    """Flatten every text block's text into one string and collect every
    citation span across all blocks into a single, de-duplicated list.

    ``source_url`` is the real link to the primary source (e.g. the
    Congress.gov bill page) — Claude's citation objects only carry the
    ``document_title`` we set as ``source_label``, not a URL, so the
    caller supplies it and every citation from this document points there.
    """
    text_parts: list[str] = []
    citations: list[Citation] = []
    seen: set[str] = set()

    for block in response.content:
        if block.type != "text":
            continue
        text_parts.append(block.text)
        for c in getattr(block, "citations", None) or []:
            if c.cited_text in seen:
                continue
            seen.add(c.cited_text)
            citations.append(
                Citation(
                    label=c.document_title,
                    url=source_url,
                    cited_text=c.cited_text,
                )
            )

    return "".join(text_parts).strip(), citations


def draft_what_happened(
    source_label: str, source_url: str, source_text: str
) -> SourcedText:
    prompt = (PROMPTS_DIR / "what_happened.md").read_text()
    client = _client()
    response = client.messages.create(
        model=MODEL,
        max_tokens=1024,
        thinking={"type": "adaptive"},
        system=_system_blocks(),
        messages=[
            {
                "role": "user",
                "content": [
                    _document_block(source_label, source_text),
                    {"type": "text", "text": prompt},
                ],
            }
        ],
    )
    text, citations = _extract_text_and_citations(response, source_url)
    return SourcedText(text=text, citations=citations)


def draft_why_it_matters(
    source_label: str, source_url: str, source_text: str, what_happened_text: str
) -> SourcedText:
    prompt = (PROMPTS_DIR / "why_it_matters.md").read_text()
    client = _client()
    response = client.messages.create(
        model=MODEL,
        max_tokens=1024,
        thinking={"type": "adaptive"},
        system=_system_blocks(),
        messages=[
            {
                "role": "user",
                "content": [
                    _document_block(source_label, source_text),
                    {
                        "type": "text",
                        "text": f'"What happened" text already drafted:\n\n'
                        f'"{what_happened_text}"\n\n{prompt}',
                    },
                ],
            }
        ],
    )
    text, citations = _extract_text_and_citations(response, source_url)
    return SourcedText(text=text, citations=citations)


def draft_argument_side(
    source_label: str,
    source_text: str,
    what_happened_text: str,
    side: Literal["supporters", "opponents"],
) -> ArgumentSide:
    prompt = (PROMPTS_DIR / "steelman.md").read_text()
    label = "Supporters argue" if side == "supporters" else "Opponents argue"
    client = _client()
    response = client.messages.create(
        model=MODEL,
        max_tokens=1024,
        thinking={"type": "adaptive"},
        system=_system_blocks(),
        messages=[
            {
                "role": "user",
                "content": [
                    _document_block(source_label, source_text),
                    {
                        "type": "text",
                        "text": f'"What happened": "{what_happened_text}"\n\n'
                        f"You are writing the **{side}** side.\n\n{prompt}",
                    },
                ],
            }
        ],
    )
    # The steelman panels only cite facts inline in prose (per
    # prompts/steelman.md) and aren't rendered with a citation list in the
    # UI, so the structured citation objects aren't needed here.
    text, _citations = _extract_text_and_citations(response, source_url="")
    return ArgumentSide(label=label, text=text, word_count=len(text.split()))


def draft_check(
    headline: str,
    what_happened_text: str,
    why_it_matters_text: str,
    side_a_text: str,
    side_b_text: str,
) -> Check:
    """The one structured-output pass — no document/citations block, since
    the two are mutually incompatible in a single request. This call is
    grounded in the already-drafted (and already citation-checked) story
    text instead of the raw primary source.
    """
    prompt = (PROMPTS_DIR / "check.md").read_text()
    story_context = (
        f"Headline: {headline}\n\n"
        f"What happened: {what_happened_text}\n\n"
        f"Why it matters: {why_it_matters_text}\n\n"
        f"Supporters argue: {side_a_text}\n\n"
        f"Opponents argue: {side_b_text}"
    )
    client = _client()
    response = client.messages.parse(
        model=MODEL,
        max_tokens=1024,
        thinking={"type": "adaptive"},
        system=_system_blocks(),
        messages=[
            {"role": "user", "content": f"{story_context}\n\n{prompt}"}
        ],
        output_format=Check,
    )
    return response.parsed_output
