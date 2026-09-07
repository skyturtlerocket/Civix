#!/usr/bin/env python3
"""Validate a Civix brief JSON file against schema/brief.schema.json.

Usage: python3 schema/validate_brief.py <path-to-brief.json> [more paths...]
"""
import json
import sys
from pathlib import Path

import jsonschema

SCHEMA_PATH = Path(__file__).parent / "brief.schema.json"


def validate(brief_path: Path) -> list[str]:
    schema = json.loads(SCHEMA_PATH.read_text())
    brief = json.loads(brief_path.read_text())
    validator = jsonschema.Draft7Validator(schema)
    errors = sorted(validator.iter_errors(brief), key=lambda e: e.path)
    return [f"{'/'.join(str(p) for p in e.path)}: {e.message}" for e in errors]


def main() -> int:
    if len(sys.argv) < 2:
        print("usage: validate_brief.py <brief.json> [...]", file=sys.stderr)
        return 2
    failed = False
    for arg in sys.argv[1:]:
        path = Path(arg)
        errors = validate(path)
        if errors:
            failed = True
            print(f"FAIL {path}")
            for err in errors:
                print(f"  - {err}")
        else:
            print(f"OK   {path}")
    return 1 if failed else 0


if __name__ == "__main__":
    raise SystemExit(main())
