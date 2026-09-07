from __future__ import annotations

from civix.checks import run_gates
from civix.checks.citations import check_citation_coverage
from civix.checks.loaded_language import check_loaded_language
from civix.checks.parity import check_parity
from civix.checks.readability import check_readability
from civix.models import Argument, ArgumentSide, Citation, SourcedText, Story


def test_balanced_story_passes_all_gates(balanced_story: Story, source_documents: dict) -> None:
    report = run_gates(balanced_story, source_documents)
    assert report.passed, report.failures


def test_citation_coverage_fails_on_hallucinated_quote(source_documents: dict) -> None:
    block = SourcedText(
        text="This is an unsourced claim.",
        citations=[
            Citation(
                label="H.R. 9999, Test Congress",
                url="https://example.gov/hr9999",
                cited_text="this exact phrase never appears in the source document",
            )
        ],
    )
    result = check_citation_coverage(block, source_documents)
    assert not result.passed
    assert "hallucinated" in result.issues[0].reason


def test_citation_coverage_flags_missing_source_document(source_documents: dict) -> None:
    # Needs a cited_text span to exercise the source-document lookup at
    # all — a citation with no cited_text is intentionally treated as
    # "unverifiable, human already checked it" and never reaches that
    # lookup (see check_citation_coverage's docstring).
    block = SourcedText(
        text="A claim citing a label we never fetched.",
        citations=[
            Citation(
                label="Some Other Bill",
                url="https://example.gov/other",
                cited_text="a quote from a bill we never actually fetched",
            )
        ],
    )
    result = check_citation_coverage(block, source_documents)
    assert not result.passed
    assert result.issues[0].reason.startswith("no source document")


def test_parity_fails_on_40_percent_imbalance() -> None:
    short_text = "Supporters argue this is a good idea for several clear reasons."
    long_text = (
        "Opponents argue this is a bad idea for a very long list of reasons "
        "that goes on at considerably greater length than the other side's "
        "case, covering cost, precedent, enforcement, unintended side "
        "effects, and a handful of hypothetical scenarios raised in "
        "committee testimony that critics found persuasive enough to "
        "include here at length."
    )
    argument = Argument(
        side_a=ArgumentSide(
            label="Supporters argue", text=short_text, word_count=len(short_text.split())
        ),
        side_b=ArgumentSide(
            label="Opponents argue", text=long_text, word_count=len(long_text.split())
        ),
    )
    result = check_parity(argument)
    assert not result.passed
    assert result.imbalance > 0.10


def test_parity_fails_when_declared_word_count_is_wrong() -> None:
    argument = Argument(
        side_a=ArgumentSide(label="Supporters argue", text="one two three", word_count=99),
        side_b=ArgumentSide(label="Opponents argue", text="one two three", word_count=3),
    )
    result = check_parity(argument)
    assert not result.passed
    assert "word_count" in result.reason


def test_loaded_language_catches_charged_words() -> None:
    result = check_loaded_language(
        "Lawmakers slammed the radical, unprecedented handout in a fiery debate."
    )
    assert not result.passed
    assert "slammed" in result.hits
    assert "radical" in result.hits
    assert "unprecedented" in result.hits
    assert "handout" in result.hits


def test_loaded_language_passes_neutral_text() -> None:
    result = check_loaded_language(
        "The House passed the bill by a vote of 240 to 190 on August 15."
    )
    assert result.passed
    assert result.hits == []


def test_readability_fails_on_dense_academic_text() -> None:
    dense = (
        "Notwithstanding the aforementioned jurisdictional prerequisites, the "
        "promulgation of the instant regulatory framework necessitates a "
        "comprehensive reassessment of the antecedent statutory "
        "interpretations heretofore adjudicated by subordinate tribunals, "
        "particularly insofar as such interpretations bear upon the "
        "constitutionality of delegated rulemaking authority."
    )
    result = check_readability(dense)
    assert not result.passed
