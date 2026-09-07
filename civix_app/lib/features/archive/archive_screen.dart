import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
          if (briefs.isEmpty) {
            return const Center(child: Text('No past briefs cached yet.'));
          }
          return ListView.builder(
            itemCount: briefs.length,
            itemBuilder: (context, index) {
              final brief = briefs[index];
              return ListTile(
                leading: const Icon(Icons.article_outlined),
                title: Text(brief.briefId),
                subtitle: Text('${brief.stories.length} stories'),
                onTap: () => context.push('/brief/${brief.briefId}'),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const Center(child: Text('Could not load the archive.')),
      ),
    );
  }
}
