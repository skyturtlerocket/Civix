"""Ingest court opinions (Supreme Court and circuit courts).

There's no official government JSON API for opinions the way there is for
Congress.gov or the Federal Register — this module targets CourtListener
(from the nonprofit Free Law Project, https://www.courtlistener.com), the
standard free source for structured opinion data and docket status
(including cert grants).

VERIFICATION STATUS: lower confidence than the other two ingest modules —
confirm the exact endpoint path and current API version during Milestone
0 at https://www.courtlistener.com/help/api/rest/ before relying on this.
Auth is a free API token sent as an `Authorization: Token <token>` header.
"""
from __future__ import annotations

import os

import httpx

from civix.ingest.base import RawSource

BASE_URL = "https://www.courtlistener.com/api/rest/v4"


def _headers() -> dict[str, str]:
    token = os.environ.get("COURTLISTENER_API_TOKEN")
    if not token:
        raise RuntimeError(
            "COURTLISTENER_API_TOKEN is not set — get a free token at "
            "https://www.courtlistener.com/sign-in/"
        )
    return {"Authorization": f"Token {token}"}


def fetch_opinion(opinion_id: int) -> RawSource:
    with httpx.Client(base_url=BASE_URL, timeout=30, headers=_headers()) as client:
        response = client.get(f"/opinions/{opinion_id}/")
        response.raise_for_status()
        data = response.json()

    case_name = data.get("cluster", {}).get("case_name", f"Opinion {opinion_id}")
    plain_text = data.get("plain_text") or data.get("html", "")
    url = f"https://www.courtlistener.com{data.get('absolute_url', '')}"

    return RawSource(
        id=f"opinion-{opinion_id}",
        label=case_name,
        url=url,
        text=plain_text,
        topics=[],
        summary=case_name,
    )
