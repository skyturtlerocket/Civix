import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'streak_controller.dart';

/// The small flame + count shown in the app bar — the only place streak
/// state is surfaced outside the completion celebration. Deliberately not
/// a leaderboard or anything comparative; see the plan's "no leaderboards
/// in v1" rule.
class StreakBadge extends ConsumerWidget {
  const StreakBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakAsync = ref.watch(streakControllerProvider);
    return streakAsync.when(
      data: (streak) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.local_fire_department, size: 20),
            const SizedBox(width: 4),
            Text('${streak.currentStreak}', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}
