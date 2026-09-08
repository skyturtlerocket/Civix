import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/topic_style.dart';
import '../../data/models/brief.dart';
import '../../data/repository/brief_providers.dart';

/// Past briefs, newest first — pulled from the local cache only (Drift),
/// so it works offline and never re-fetches from the network.
class ArchiveScreen extends ConsumerWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final archiveAsync = ref.watch(archiveProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Past briefs')),
      body: archiveAsync.when(
        data: (briefs) {
          if (briefs.isEmpty) return const _EmptyState();
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            itemCount: briefs.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) => _BriefTile(brief: briefs[index]),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const Center(child: Text('Could not load the archive.')),
      ),
    );
  }
}

class _BriefTile extends StatelessWidget {
  const _BriefTile({required this.brief});

  final Brief brief;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Every story's topic, deduped, so a row previews what's inside.
    final topics = <String, TopicStyle>{};
    for (final story in brief.stories) {
      final style = TopicStyle.forStory(story.topics);
      topics.putIfAbsent(style.label, () => style);
    }
    final lead = topics.values.isEmpty
        ? TopicStyle.forStory(const [])
        : topics.values.first;

    return Material(
      color: theme.colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => context.push('/brief/${brief.briefId}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  color: lead.color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(lead.icon, color: lead.color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_prettyDate(brief), style: theme.textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(
                      '${brief.stories.length} '
                      '${brief.stories.length == 1 ? "story" : "stories"}'
                      '${topics.isEmpty ? "" : " · ${topics.keys.take(2).join(", ")}"}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: theme.colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }

  /// briefId is an ISO date; show it the way a person would say it, and
  /// fall back to the raw id if it ever isn't parseable.
  String _prettyDate(Brief brief) {
    final parsed = DateTime.tryParse(brief.briefId);
    if (parsed == null) return brief.briefId;
    return DateFormat('EEEE, MMMM d').format(parsed);
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.surfaceContainerHighest,
              ),
              child: Icon(Icons.history_rounded,
                  size: 34, color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 20),
            Text('No past briefs cached yet.', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              "Briefs you read are saved here automatically, and stay readable offline.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
