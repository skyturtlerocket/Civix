import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// The credibility of the whole app rests on this page being honest and
/// easy to find — see the plan's "publish your methodology" rule.
class MethodologyScreen extends StatelessWidget {
  const MethodologyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('How Civix works')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('What Civix is', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          const Text(
            'Every story in Civix is grounded in a primary source — a bill, '
            'a final rule, a court opinion, or a roll-call vote — not a '
            'news article about one. Every claim in "what happened" and '
            '"why it matters" links to that source.',
          ),
          const SizedBox(height: 20),
          Text('How the argument panel works', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          const Text(
            'For contested topics, we write the strongest honest case for '
            'each side — the version a thoughtful person holding that view '
            'would recognize as fair — at the same length, in the same '
            'size box. We label sides by position ("Supporters argue" / '
            '"Opponents argue"), never by party.',
          ),
          const SizedBox(height: 20),
          Text('How a story gets published', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          const Text(
            'A draft is written by an AI model grounded in the primary '
            'source, then run through automated checks — citation '
            'coverage, word-balance between the two sides, and a check for '
            'loaded language — before a human reviewer reads and approves '
            'it. Nothing publishes without that human approval.',
          ),
          const SizedBox(height: 20),
          Text('Think we got something wrong?', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          const Text(
            "If a story reads as unbalanced or a fact looks off, tell us — "
            "that's exactly the kind of thing we want to catch.",
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => launchUrl(Uri.parse('mailto:hello@civix.app?subject=Feedback')),
            icon: const Icon(Icons.mail_outline),
            label: const Text('Send feedback'),
          ),
        ],
      ),
    );
  }
}
