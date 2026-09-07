"""Citation-coverage gate.

The schema already requires at least one citation per SourcedText block
(a story with zero citations fails model validation before it gets here).
This gate does the check that actually matters: when a citation carries a
`cited_text` span from the Claude citations feature, verify that span is a
real substring of the primary source document — not a hallucinated quote
that merely looks like a citation.

Citations without a `cited_text` span (e.g. a hand-added citation during
human review) are allowed through but flagged, since they can't be
mechanically verified — a reviewer is expected to have checked them.
"""
from __future__ import annotations

from pydantic import BaseModel

from civix.models import SourcedText


class CitationIssue(BaseModel):
    citation_label: str
    reason: str


class CitationCoverageResult(BaseModel):
    passed: bool
    unverifiable_count: int  # citations with no cited_text span to check
    issues: list[CitationIssue]


def check_citation_coverage(
    block: SourcedText, source_documents: dict[str, str]
) -> CitationCoverageResult:
    """Verify each citation's ``cited_text`` (if present) is a real
    substring of the source document it claims to come from.

    ``source_documents`` maps a citation's ``label`` to the full primary
    source text the drafting call was given, so callers only need to pass
    through what was already fetched at ingest time.
    """
    issues: list[CitationIssue] = []
    unverifiable = 0

    for citation in block.citations:
        if citation.cited_text is None:
            unverifiable += 1
            continue

        source_text = source_documents.get(citation.label)
        if source_text is None:
            issues.append(
                CitationIssue(
                    citation_label=citation.label,
                    reason="no source document was provided for this citation label",
                )
            )
            continue

        if citation.cited_text.strip() not in source_text:
            issues.append(
                CitationIssue(
                    citation_label=citation.label,
                    reason="cited_text is not a substring of the source document "
                    "(possible hallucinated quote)",
                )
            )

    return CitationCoverageResult(
        passed=len(issues) == 0,
        unverifiable_count=unverifiable,
        issues=issues,
    )
