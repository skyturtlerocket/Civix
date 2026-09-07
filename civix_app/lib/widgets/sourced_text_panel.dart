import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/models/sourced_text.dart';

/// Renders a block of prose (what happened / why it matters) plus its
/// citation chips underneath — every claim in a Civix card is meant to be
/// one tap from its primary source, not just asserted.
class SourcedTextPanel extends StatelessWidget {
  const SourcedTextPanel({super.key, required this.heading, required this.content});

  final String heading;
  final SourcedText content;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(heading, style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(content.text, style: theme.textTheme.bodyLarge),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final citation in content.citations)
              ActionChip(
                avatar: const Icon(Icons.link, size: 16),
                label: Text(citation.label, overflow: TextOverflow.ellipsis),
                onPressed: () => _openCitation(context, citation.url),
              ),
          ],
        ),
      ],
    );
  }

  Future<void> _openCitation(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open $url')),
      );
    }
  }
}
