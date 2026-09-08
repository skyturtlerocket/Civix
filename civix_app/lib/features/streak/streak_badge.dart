import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme.dart';
import 'streak_controller.dart';

/// The flame + count pill in the app bar. Still deliberately not a
/// leaderboard or anything comparative — it shows your own number and
/// nobody else's; see the plan's "no leaderboards in v1" rule.
class StreakBadge extends ConsumerWidget {
  const StreakBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakAsync = ref.watch(streakControllerProvider);
    return streakAsync.when(
      data: (streak) {
        // A zero streak is greyed rather than hidden, so the pill doesn't
        // pop into existence on day one and startle the layout.
        final live = streak.currentStreak > 0;
        final color = live ? CivixTheme.accents[2] : Theme.of(context).colorScheme.onSurfaceVariant;

        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: color.withValues(alpha: live ? 0.16 : 0.08),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: color.withValues(alpha: live ? 0.45 : 0.2)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.local_fire_department_rounded, size: 17, color: color),
                const SizedBox(width: 5),
                Text(
                  '${streak.currentStreak}',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}
