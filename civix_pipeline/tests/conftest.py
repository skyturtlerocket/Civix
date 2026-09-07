from __future__ import annotations

import pytest

from civix.models import Argument, ArgumentSide, Check, Citation, SourcedText, Story

FIXTURE_SOURCE_LABEL = "H.R. 9999, Test Congress"
FIXTURE_SOURCE_TEXT = (
    "Title: Student Transit Access Act.\n\n"
    "Latest action: Passed the House of Representatives by a vote of 240-190 "
    "on August 15, 2026. The bill would direct the Department of "
    "Transportation to fund free transit passes for public high school "
    "students in participating cities for a two-year pilot period."
)


@pytest.fixture
def source_documents() -> dict[str, str]:
    return {FIXTURE_SOURCE_LABEL: FIXTURE_SOURCE_TEXT}


def _side(label: str, text: str) -> ArgumentSide:
    return ArgumentSide(label=label, text=text, word_count=len(text.split()))


@pytest.fixture
def balanced_story(source_documents: dict[str, str]) -> Story:
    return Story(
        id="hr9999-passage",
        headline="House passes bill funding free transit for high schoolers",
        topics=["education", "economy"],
        what_happened=SourcedText(
            text=(
                "The House passed a bill funding free transit passes for "
                "public high school students. Participating cities would "
                "run the program for a two-year pilot period."
            ),
            citations=[
                Citation(
                    label=FIXTURE_SOURCE_LABEL,
                    url="https://example.gov/hr9999",
                    cited_text="Passed the House of Representatives by a vote of 240-190",
                )
            ],
        ),
        why_it_matters=SourcedText(
            text=(
                "If you're a high schooler in a participating city, this "
                "could mean free rides to school, practice, or a job for the "
                "next two years."
            ),
            citations=[
                Citation(
                    label=FIXTURE_SOURCE_LABEL,
                    url="https://example.gov/hr9999",
                    cited_text="fund free transit passes for public high school students",
                )
            ],
        ),
        argument=Argument(
            side_a=_side(
                "Supporters argue",
                "Supporters argue free transit removes a real cost barrier "
                "to attendance for lower income students, and that a two "
                "year pilot lets the program prove its effect before any "
                "larger commitment is made by Congress or participating "
                "cities.",
            ),
            side_b=_side(
                "Opponents argue",
                "Opponents argue the pilot draws funding from the same "
                "transit budget that covers route frequency, and that the "
                "money might raise ridership more broadly if spent on "
                "service improvements instead of a narrow fare exemption "
                "for one age group.",
            ),
        ),
        check=Check(
            question="How long is this pilot funded for?",
            options=["One year", "Two years", "Five years", "Indefinitely"],
            answer_index=1,
            explanation="The bill funds a two-year pilot period, not a permanent program.",
        ),
    )
