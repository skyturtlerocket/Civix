import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../app/theme.dart';
import 'streak_logic.dart';

/// Shown once, right after the last story's check is answered.
///
/// This is the app's one moment of celebration, and it's deliberately
/// bounded: it plays once, it's over in about a second, and it doesn't
/// offer anything to tap for more. The plan's objection was to
/// slot-machine mechanics — variable rewards, near-miss animations, "one
/// more" loops — not to the reader feeling good about finishing. Nothing
/// here is randomised and nothing here asks for another session.
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
    return Dialog(
      backgroundColor: theme.colorScheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const _Burst(),
                  Container(
                    height: 84,
                    width: 84,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [CivixTheme.accents[2], CivixTheme.accents[5]],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Icon(Icons.local_fire_department_rounded,
                        size: 46, color: Colors.white),
                  )
                      .animate()
                      .scaleXY(begin: 0.4, end: 1, duration: 420.ms, curve: Curves.elasticOut)
                      .fadeIn(duration: 200.ms),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text("That's today's brief", style: theme.textTheme.headlineSmall),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Stat(
                  value: '${streak.currentStreak}',
                  label: streak.currentStreak == 1 ? 'day streak' : 'day streak',
                  color: CivixTheme.accents[2],
                ),
                const SizedBox(width: 12),
                _Stat(
                  value: '${streak.totalXp}',
                  label: 'total XP',
                  color: CivixTheme.accents[1],
                ),
              ],
            ),
            if (streak.freezesAvailable > 0) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.ac_unit_rounded, size: 16, color: theme.colorScheme.onSurfaceVariant),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      'A streak freeze is saved for a day you have to miss.',
                      style: theme.textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Done'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label, required this.color});

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 30,
                fontWeight: FontWeight.w900,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 220.ms, duration: 300.ms).slideY(begin: 0.25, end: 0);
  }
}

/// Twelve fixed rays behind the badge. Fixed, not random — the payout is
/// the same every day, which is exactly the point.
class _Burst extends StatelessWidget {
  const _Burst();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (var i = 0; i < 12; i++)
            Transform.rotate(
              angle: i * math.pi / 6,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 4,
                  height: 14,
                  decoration: BoxDecoration(
                    color: CivixTheme.accents[i % CivixTheme.accents.length],
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 200.ms, delay: (100 + i * 18).ms)
                .scaleXY(begin: 0.2, end: 1, curve: Curves.easeOutBack)
                .then(delay: 400.ms)
                .fadeOut(duration: 500.ms),
        ],
      ),
    );
  }
}
