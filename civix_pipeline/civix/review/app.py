"""Stage 5 — the local human-approval UI.

Deliberately minimal: FastAPI serving server-rendered HTML with a little
htmx for the approve/reject/edit actions, no build step, no JS framework.
This runs on localhost only — it is the one gate in the whole pipeline
that must never be automated away, so it doesn't need to be more than
"open a browser tab, read a draft, click a button."

Run with: uvicorn civix.review.app:app --reload
"""
from __future__ import annotations

import json
from datetime import UTC, datetime
from pathlib import Path

from fastapi import FastAPI, Form, HTTPException
from fastapi.responses import HTMLResponse, RedirectResponse

from civix.models import ReviewInfo, Story

PIPELINE_ROOT = Path(__file__).resolve().parent.parent.parent
DRAFTS_DIR = PIPELINE_ROOT / "data" / "drafts"
APPROVED_DIR = PIPELINE_ROOT / "data" / "approved"

app = FastAPI(title="Civix review")


def _list_draft_ids() -> list[str]:
    if not DRAFTS_DIR.exists():
        return []
    return sorted(p.stem for p in DRAFTS_DIR.glob("*.json"))


def _load_draft(story_id: str) -> dict:
    path = DRAFTS_DIR / f"{story_id}.json"
    if not path.exists():
        raise HTTPException(404, f"no draft named {story_id}")
    return json.loads(path.read_text())


def _page(body: str) -> HTMLResponse:
    return HTMLResponse(f"""<!doctype html>
<html>
<head>
  <title>Civix review</title>
  <script src="https://unpkg.com/htmx.org@2.0.4"></script>
  <style>
    body {{ font-family: system-ui, sans-serif; max-width: 900px; margin: 2rem auto; padding: 0 1rem; }}
    .panel {{ display: flex; gap: 1rem; margin: 1rem 0; }}
    .panel > div {{ flex: 1; border: 1px solid #ccc; border-radius: 8px; padding: 1rem; }}
    .fail {{ color: #b00020; }}
    .pass {{ color: #1a7f37; }}
    textarea {{ width: 100%; min-height: 4rem; }}
    button {{ padding: 0.5rem 1rem; margin-right: 0.5rem; cursor: pointer; }}
    .approve {{ background: #1a7f37; color: white; border: none; border-radius: 4px; }}
    .reject {{ background: #b00020; color: white; border: none; border-radius: 4px; }}
  </style>
</head>
<body>{body}</body>
</html>""")


@app.get("/", response_class=HTMLResponse)
def index() -> HTMLResponse:
    ids = _list_draft_ids()
    if not ids:
        return _page("<h1>Civix review</h1><p>No drafts waiting. Run the nightly job first.</p>")
    items = "".join(f'<li><a href="/review/{i}">{i}</a></li>' for i in ids)
    return _page(f"<h1>Civix review</h1><p>{len(ids)} draft(s) waiting.</p><ul>{items}</ul>")


@app.get("/review/{story_id}", response_class=HTMLResponse)
def review_story(story_id: str) -> HTMLResponse:
    draft = _load_draft(story_id)
    story = draft["story"]
    gates = draft["gates"]
    swap = draft["swap_test"]
    critiques = draft["critiques"]

    gate_class = "pass" if gates["passed"] else "fail"
    gate_lines = "".join(f"<li>{f}</li>" for f in gates["failures"]) or "<li>none</li>"

    swap_class = "pass" if swap["passed"] else "fail"

    body = f"""
    <p><a href="/">&larr; back</a></p>
    <h1>{story['headline']}</h1>
    <p><em>{story['id']}</em> — topics: {', '.join(story['topics'])}</p>

    <h3>What happened</h3>
    <p>{story['what_happened']['text']}</p>

    <h3>Why it matters</h3>
    <p>{story['why_it_matters']['text']}</p>

    <div class="panel">
      <div><strong>{story['argument']['side_a']['label']}</strong>
        <p>{story['argument']['side_a']['text']}</p></div>
      <div><strong>{story['argument']['side_b']['label']}</strong>
        <p>{story['argument']['side_b']['text']}</p></div>
    </div>

    <h3>Check</h3>
    <p>{story['check']['question']}</p>
    <ol type="A">{''.join(f"<li>{o}</li>" for o in story['check']['options'])}</ol>
    <p>Answer: {story['check']['options'][story['check']['answer_index']]}</p>

    <h3>Automated gates: <span class="{gate_class}">{'PASS' if gates['passed'] else 'FAIL'}</span></h3>
    <ul>{gate_lines}</ul>

    <h3>Blind swap test: <span class="{swap_class}">{'PASS' if swap['passed'] else 'FAIL'}</span></h3>
    <p>{swap.get('reason') or 'no consistent-winner slant detected'}</p>

    <h3>Two-sided critique</h3>
    <div class="panel">
      <div><strong>From the left</strong><p>{critiques['left']['critique']}</p></div>
      <div><strong>From the right</strong><p>{critiques['right']['critique']}</p></div>
    </div>

    <form method="post" action="/approve/{story_id}">
      <button class="approve" type="submit">Approve</button>
    </form>
    <form method="post" action="/reject/{story_id}">
      <button class="reject" type="submit">Reject</button>
    </form>
    """
    return _page(body)


@app.post("/approve/{story_id}")
def approve(story_id: str, edited: bool = Form(False)) -> RedirectResponse:
    draft = _load_draft(story_id)
    story = Story.model_validate(draft["story"])
    story = story.model_copy(
        update={"review": ReviewInfo(approved_at=datetime.now(UTC), edited=edited)}
    )

    APPROVED_DIR.mkdir(parents=True, exist_ok=True)
    (APPROVED_DIR / f"{story_id}.json").write_text(story.model_dump_json(by_alias=True, indent=2))
    (DRAFTS_DIR / f"{story_id}.json").unlink()

    return RedirectResponse("/", status_code=303)


@app.post("/reject/{story_id}")
def reject(story_id: str) -> RedirectResponse:
    path = DRAFTS_DIR / f"{story_id}.json"
    if path.exists():
        path.unlink()
    return RedirectResponse("/", status_code=303)
