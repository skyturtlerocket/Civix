"""Ingest from the Federal Register API (final rules).

The Federal Register API is public, free, and has not required an API key
since its introduction — this module makes unauthenticated requests. Base
URL and the document-detail endpoint shape below are long-stable; still,
confirm reachability during Milestone 0 (a live smoke test, not just
reading docs — the site has bot-protection in front of some paths).
"""
from __future__ import annotations

import httpx

from civix.ingest.base import RawSource

BASE_URL = "https://www.federalregister.gov/api/v1"


def fetch_document(document_number: str) -> RawSource:
    """Fetch one Federal Register document (a final rule) by its document
    number, e.g. "2026-12345".
    """
    with httpx.Client(base_url=BASE_URL, timeout=30) as client:
        response = client.get(
            f"/documents/{document_number}.json",
            params={
                "fields[]": [
                    "title",
                    "abstract",
                    "html_url",
                    "publication_date",
                    "agencies",
                    "body_html_url",
                ]
            },
        )
        response.raise_for_status()
        data = response.json()

    title = data.get("title", document_number)
    abstract = data.get("abstract", "")
    agencies = ", ".join(a.get("name", "") for a in data.get("agencies", []))

    return RawSource(
        id=f"fr-{document_number}",
        label=f"Federal Register, {title}",
        url=data.get("html_url", f"https://www.federalregister.gov/d/{document_number}"),
        text=f"Title: {title}\nAgency: {agencies}\n\nAbstract: {abstract}",
        topics=[],
        summary=title,
    )
