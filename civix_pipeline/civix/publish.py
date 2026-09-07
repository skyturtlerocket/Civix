"""Stage 6 — assemble approved stories into a Brief and publish it.

Reads only from data/approved/ (never data/drafts/ — that boundary is the
whole point of Stage 5: nothing reaches here without a human having
clicked approve). Writes a schema-validated Brief to data/published/ as
the local source of truth, then optionally uploads it to object storage
in front of a CDN.
"""
from __future__ import annotations

import json
import os
from datetime import UTC, datetime
from pathlib import Path

import jsonschema

from civix.models import Brief, Story

PIPELINE_ROOT = Path(__file__).resolve().parent.parent
APPROVED_DIR = PIPELINE_ROOT / "data" / "approved"
PUBLISHED_DIR = PIPELINE_ROOT / "data" / "published"
SCHEMA_PATH = PIPELINE_ROOT.parent / "schema" / "brief.schema.json"


def _load_schema() -> dict:
    return json.loads(SCHEMA_PATH.read_text())


def build_brief(brief_id: str, story_ids: list[str]) -> Brief:
    """Load each approved story by id, in the given order, into one Brief.

    Ordering is an explicit argument rather than "whatever's in the
    directory" — story order is an editorial choice (what leads the brief)
    and shouldn't be left to filesystem iteration order.
    """
    stories: list[Story] = []
    for story_id in story_ids:
        path = APPROVED_DIR / f"{story_id}.json"
        if not path.exists():
            raise FileNotFoundError(f"approved story not found: {path}")
        stories.append(Story.model_validate_json(path.read_text()))

    return Brief(
        brief_id=brief_id,
        published_at=datetime.now(UTC),
        schema_version=1,
        stories=stories,
    )


def validate_brief(brief: Brief) -> None:
    """Raises jsonschema.ValidationError on any mismatch with
    schema/brief.schema.json — the wire contract shared with civix_app.
    """
    schema = _load_schema()
    # exclude_none: the schema treats `review` as either absent or an
    # object — never null — and pydantic's default dump emits `null` for
    # every unset Optional field, which fails validation otherwise.
    payload = json.loads(brief.model_dump_json(by_alias=True, exclude_none=True))
    jsonschema.validate(payload, schema)


def write_local(brief: Brief) -> tuple[Path, Path]:
    """Write the dated file plus latest.json, both schema-validated first."""
    validate_brief(brief)
    PUBLISHED_DIR.mkdir(parents=True, exist_ok=True)

    payload = brief.model_dump_json(by_alias=True, exclude_none=True, indent=2)
    dated_path = PUBLISHED_DIR / f"{brief.brief_id}.json"
    latest_path = PUBLISHED_DIR / "latest.json"

    dated_path.write_text(payload)
    latest_path.write_text(payload)
    return dated_path, latest_path


def publish_to_cdn(dated_path: Path, latest_path: Path) -> None:
    """Upload both files to the configured S3-compatible bucket (e.g.
    Cloudflare R2). Requires CIVIX_CDN_BUCKET, CIVIX_CDN_ENDPOINT_URL,
    CIVIX_CDN_ACCESS_KEY_ID, and CIVIX_CDN_SECRET_ACCESS_KEY to be set —
    raises a clear error naming whichever is missing rather than a raw
    boto3 traceback, since this is the step most likely to be run without
    the full env configured yet.
    """
    import boto3  # local import: only this function needs it

    required = [
        "CIVIX_CDN_BUCKET",
        "CIVIX_CDN_ENDPOINT_URL",
        "CIVIX_CDN_ACCESS_KEY_ID",
        "CIVIX_CDN_SECRET_ACCESS_KEY",
    ]
    missing = [name for name in required if not os.environ.get(name)]
    if missing:
        raise RuntimeError(f"publish_to_cdn: missing env vars: {', '.join(missing)}")

    client = boto3.client(
        "s3",
        endpoint_url=os.environ["CIVIX_CDN_ENDPOINT_URL"],
        aws_access_key_id=os.environ["CIVIX_CDN_ACCESS_KEY_ID"],
        aws_secret_access_key=os.environ["CIVIX_CDN_SECRET_ACCESS_KEY"],
    )
    bucket = os.environ["CIVIX_CDN_BUCKET"]

    for local_path in (dated_path, latest_path):
        client.upload_file(
            str(local_path),
            bucket,
            f"briefs/{local_path.name}",
            ExtraArgs={"ContentType": "application/json", "CacheControl": "max-age=300"},
        )


def publish(brief_id: str, story_ids: list[str], upload: bool = False) -> Brief:
    brief = build_brief(brief_id, story_ids)
    dated_path, latest_path = write_local(brief)
    if upload:
        publish_to_cdn(dated_path, latest_path)
    return brief
