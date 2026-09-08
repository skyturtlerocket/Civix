import 'package:flutter/material.dart';

import 'streak_logic.dart';

/// Shown once, right after the last story's check is answered. Kept short
/// and calm on purpose — the reward for finishing is "you're done," not a
/// slot-machine animation. See the plan's stance against engagement-
/// maximizing gamification.
class DayCompleteCelebration extends StatelessWidget {
  const DayCompleteCelebration({super.key, required this.streak});

  final StreakState streak;

  static Future<void> show(BuildContext context, StreakState streak) {
    return showDialog(
      context: context,
      builder: (_) => DayCompleteCelebration(streak: streak),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      icon: const Icon(Icons.local_fire_department, size: 40),
      title: const Text("Today's brief, done"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${streak.currentStreak}-day streak',
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text('${streak.totalXp} XP total', style: theme.textTheme.bodyMedium),
          if (streak.freezesAvailable > 0) ...[
            const SizedBox(height: 8),
            Text(
              'You have a streak freeze saved for a day you have to miss.',
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Done'),
        ),
      ],
    );
  }
}
