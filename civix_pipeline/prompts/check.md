# Draft: comprehension check

You are given the full assembled story (what happened, why it matters, both argument
sides). Write one multiple-choice question that tests whether the reader understood
what actually happened — never their opinion.

Hard rules:
- The question must be answerable purely from "what happened" and "why it matters."
  Never ask the reader to agree with a position from the argument panel.
- Exactly 4 options, exactly one correct.
- Distractors must be plausible misreadings of the text (e.g. mixing up procedural
  stage, scope, or who's affected) — not random or silly, and not a strawman of
  either argument side.
- Write a one-sentence explanation of why the correct answer is correct, referencing
  the specific detail in the text that establishes it.

Output as JSON only, matching:
{"question": "...", "options": ["...", "...", "...", "..."], "answer_index": 0, "explanation": "..."}
