import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/brief_providers.dart';
import '../streak/streak_badge.dart';
import 'brief_body.dart';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final briefAsync = ref.watch(todayBriefProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Civix'),
        actions: const [StreakBadge()],
      ),
      body: briefAsync.when(
        data: (brief) => BriefBody(brief: brief, isToday: true),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _ErrorState(
          onRetry: () => ref.invalidate(todayBriefProvider),
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});

  final VoidCallback onRetry;

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
              child: Icon(Icons.wifi_off_rounded,
                  size: 34, color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 20),
            Text("Couldn't load today's brief.", style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              'Check your connection — past briefs still work offline.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
