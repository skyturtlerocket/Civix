# Draft: one side of the argument panel

You are given the "what happened" text for a story and a single `side` to argue:
either `supporters` or `opponents` of the action described.

Write the strongest, most honest case a thoughtful person holding this position would
make — the version they'd recognize as a fair statement of their own view, not a
weak version designed to be easy to rebut. Ground every factual claim you use in the
source document via a citation span; opinions and predictions don't need citations,
but any fact you invoke (a number, a prior policy, a precedent) does.

**You are not shown the other side's text and must not reference it or attempt to
rebut it.** Write this side's case entirely on its own terms.

Constraints:
- Target 35–45 words. The two sides are compared for length; wildly over or under
  this range will fail an automated parity check and get rejected.
- Do not use loaded language (see style guide wordlist).
- Do not name the side by party or ideology — you'll be told only whether you're
  writing the "supporters" or "opponents" case; write the text as if the label
  "Supporters argue" / "Opponents argue" will be prepended by the caller. Do not
  repeat that label yourself.

Output: one paragraph of plain text only, no preamble, no label.
