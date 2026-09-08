import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/models/sourced_text.dart';

/// Renders a block of prose (what happened / why it matters) plus its
/// citation chips underneath — every claim in a Civix card is meant to be
/// one tap from its primary source, not just asserted.
class SourcedTextPanel extends StatelessWidget {
  const SourcedTextPanel({
    super.key,
    required this.heading,
    required this.content,
    this.accent,
  });

  final String heading;
  final SourcedText content;

  /// The story's topic colour, used to tint the citation chips so sources
  /// read as part of the card rather than as generic UI furniture.
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = accent ?? theme.colorScheme.primary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(content.text, style: theme.textTheme.bodyLarge),
        const SizedBox(height: 20),
        Text(
          'SOURCES',
          style: theme.textTheme.labelLarge?.copyWith(
            fontSize: 10.5,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final citation in content.citations)
              ActionChip(
                avatar: Icon(Icons.link_rounded, size: 16, color: accentColor),
                label: Text(citation.label, overflow: TextOverflow.ellipsis),
                labelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5, color: accentColor),
                side: BorderSide(color: accentColor.withValues(alpha: 0.45)),
                backgroundColor: accentColor.withValues(alpha: 0.10),
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
