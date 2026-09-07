# Civix

Unbiased, sourced political briefs for teenagers — five short story cards a day,
each grounded in a primary source, each with a symmetric two-sided argument panel,
each closing with a comprehension check. See `plan.md`-equivalent context in the
original planning session for the why; this file is the how-to-run.

Two independent programs, joined by one contract:

```
schema/brief.schema.json   <- the wire format both sides agree on
fixtures/*.json             <- two hand-written sample briefs conforming to it
civix_app/                  <- Flutter client (reads briefs, tracks streak/XP)
civix_pipeline/              <- Python pipeline (drafts briefs with Claude, gates them,
                                human-approves, publishes)
```

## Status

- **`civix_app`**: builds clean (`flutter analyze` — 0 issues), full test suite passes
  (31/31 — models, streak logic, repository caching/fallback, argument-panel symmetry,
  full app boot). Runs entirely against the two bundled sample briefs in
  `assets/sample_briefs/` until a real CDN is wired up.
- **`civix_pipeline`**: full test suite passes (11 passed, 1 skipped — the skipped one
  needs a live `ANTHROPIC_API_KEY`). The approve → publish → schema-validate flow was
  run end-to-end against real fixture data.
- **Not yet run on a real device or simulator** — this environment has Command Line
  Tools but not the full Xcode.app, so `flutter run -d macos/ios` can't build the
  native shell here. `flutter test` exercises the real widget tree, real SQLite (via
  Drift's native FFI), and real SharedPreferences plugin logic, but a real interactive
  run-through on a device/simulator is still the next step once Xcode (or an Android
  SDK) is available.
- **Ingest modules** (`civix_pipeline/civix/ingest/`) are honestly flagged by
  confidence level in their docstrings — Federal Register is high-confidence and
  stable; Congress.gov's bill endpoint is solid but its vote endpoint needs a
  live-docs check; CourtListener is lower-confidence and needs verifying against
  `https://www.courtlistener.com/help/api/rest/` before relying on it. This is the
  plan's Milestone 0 verification step — partially done, flagged where it isn't.

## Setting up on a new machine

See **[SETUP.md](SETUP.md)** for a from-scratch guide — Flutter, the Android
SDK, an emulator, and the disk budget it all needs. The short version, if you
already have Flutter and an Android SDK, is below.

## Running the app

```
cd civix_app
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # regenerate *.g.dart / *.freezed.dart
flutter test                                                 # full suite
flutter run -d <device>                                      # needs Xcode or Android SDK installed
```

The app works fully offline against the two bundled sample briefs — no backend, no
API key, no account needed to try it. Point it at a real published feed with:

```
flutter run --dart-define=CIVIX_CDN_BASE_URL=https://your-cdn/briefs
```

## Running the pipeline

```
cd civix_pipeline
python3 -m venv .venv && .venv/bin/pip install -r requirements.txt
export ANTHROPIC_API_KEY=...            # for draft.py / critique.py
.venv/bin/pytest                        # gate + model tests (no API key needed)
.venv/bin/pytest tests/test_integration.py -v   # live blind-swap-test check (needs the key)
```

Drafting a real story end to end (once ingest is verified — see Status above):

```python
from civix.ingest.federal_register import fetch_document
from civix.assemble import assemble_story, save_draft

source = fetch_document("2026-12345")
package = assemble_story(source, headline="...", topics=["education"])
save_draft(package)   # writes data/drafts/{story.id}.json
```

Then review it:

```
.venv/bin/uvicorn civix.review.app:app --reload
# open http://localhost:8000, approve or reject
```

Approved stories live in `data/approved/`. Publish a night's brief:

```python
from civix.publish import publish

publish("2026-09-02", story_ids=["...", "...", "...", "...", "..."], upload=True)
```

`upload=True` needs `CIVIX_CDN_BUCKET`, `CIVIX_CDN_ENDPOINT_URL`,
`CIVIX_CDN_ACCESS_KEY_ID`, `CIVIX_CDN_SECRET_ACCESS_KEY` set (S3-compatible — Cloudflare
R2 is the plan's default). Without it, `publish()` still writes the schema-validated
brief locally to `data/published/`.

## Next steps (see the plan for full detail)

1. Verify the Congress.gov vote endpoint and CourtListener against their live docs
   (flagged in the ingest modules' docstrings).
2. Install Xcode (or an Android SDK) and do a real interactive run-through: complete
   a brief, kill the app mid-story and confirm progress restores, go airplane mode.
3. Draft and approve a handful of real stories through the pipeline; publish to a
   real R2/S3 bucket; point a debug build at it.
4. Everything in the plan's "Explicitly deferred to v2" list — Spot the Spin, the
   local rep tracker, the glossary, accounts.
