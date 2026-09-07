"""Ingest from the Congress.gov API (bills, actions, roll-call votes).

VERIFICATION STATUS (as of writing — confirm during Milestone 0):
- Base URL and auth are confirmed: https://api.congress.gov/v3/, an API key
  from https://api.congress.gov/sign-up/, passed as the `api_key` query
  parameter (standard api.data.gov convention).
- The bill-detail endpoint shape (`/bill/{congress}/{billType}/{billNum}`)
  is well-established and used below with reasonably high confidence.
- The roll-call vote endpoint path is NOT independently verified in this
  pass — Congress.gov's vote data surface has changed over time. Before
  relying on `fetch_bill_actions` in production, hit
  https://api.congress.gov/ (interactive docs, requires a signed-in key)
  and confirm the current vote path, then update `_VOTE_ENDPOINT` below.
"""
from __future__ import annotations

import os

import httpx

from civix.ingest.base import RawSource

BASE_URL = "https://api.congress.gov/v3"

# TODO(M0): confirm this is still the current roll-call vote path before
# depending on it — see module docstring.
_VOTE_ENDPOINT = "/house-vote"


def _api_key() -> str:
    key = os.environ.get("CONGRESS_GOV_API_KEY")
    if not key:
        raise RuntimeError(
            "CONGRESS_GOV_API_KEY is not set — sign up at "
            "https://api.congress.gov/sign-up/"
        )
    return key


def fetch_bill(congress: int, bill_type: str, bill_number: int) -> RawSource:
    """Fetch a single bill's detail record.

    ``bill_type`` is Congress.gov's short code, e.g. "hr" for House bill,
    "s" for Senate bill.
    """
    with httpx.Client(base_url=BASE_URL, timeout=30) as client:
        response = client.get(
            f"/bill/{congress}/{bill_type}/{bill_number}",
            params={"api_key": _api_key(), "format": "json"},
        )
        response.raise_for_status()
        data = response.json()["bill"]

    title = data.get("title", f"{bill_type.upper()} {bill_number}")
    latest_action = data.get("latestAction", {}).get("text", "")
    congress_url = (
        f"https://www.congress.gov/bill/{congress}th-congress/"
        f"{'house-bill' if bill_type.lower() == 'hr' else 'senate-bill'}/{bill_number}"
    )

    return RawSource(
        id=f"{bill_type.lower()}{bill_number}-{congress}",
        label=f"{bill_type.upper()} {bill_number}, {congress}th Congress",
        url=congress_url,
        text=f"Title: {title}\n\nLatest action: {latest_action}",
        topics=[],  # left for select.py to assign from the rubric, not the API
        summary=title,
    )
