"""Stage 4 — the automated gates every draft must clear before it reaches
a human reviewer.

`run_gates` is the single entry point the rest of the pipeline calls; each
individual gate lives in its own module (citations.py, parity.py,
readability.py, loaded_language.py) so `tests/test_checks.py` can target
each one with a deliberately failing fixture.
"""
from __future__ import annotations

from pydantic import BaseModel

from civix.checks.citations import check_citation_coverage
from civix.checks.loaded_language import check_loaded_language
from civix.checks.parity import check_parity
from civix.checks.readability import check_readability
from civix.models import Story


class GateReport(BaseModel):
    passed: bool
    failures: list[str]


def run_gates(story: Story, source_documents: dict[str, str]) -> GateReport:
    failures: list[str] = []

    for block_name, block in (
        ("what_happened", story.what_happened),
        ("why_it_matters", story.why_it_matters),
    ):
        coverage = check_citation_coverage(block, source_documents)
        if not coverage.passed:
            for issue in coverage.issues:
                failures.append(f"{block_name} citation: {issue.reason}")

        loaded = check_loaded_language(block.text)
        if not loaded.passed:
            failures.append(f"{block_name} loaded language: {', '.join(loaded.hits)}")

        readability = check_readability(block.text)
        if not readability.passed:
            failures.append(f"{block_name} readability: {readability.reason}")

    for side_name, side in (
        ("side_a", story.argument.side_a),
        ("side_b", story.argument.side_b),
    ):
        loaded = check_loaded_language(side.text)
        if not loaded.passed:
            failures.append(f"{side_name} loaded language: {', '.join(loaded.hits)}")

    parity = check_parity(story.argument)
    if not parity.passed:
        failures.append(f"argument parity: {parity.reason}")

    return GateReport(passed=len(failures) == 0, failures=failures)
