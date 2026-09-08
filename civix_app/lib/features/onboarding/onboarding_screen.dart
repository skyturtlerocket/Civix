import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme.dart';
import '../../data/local/notifications.dart';
import '../settings/notification_provider.dart';
import '../streak/streak_controller.dart';

const kOnboardingCompleteKey = 'onboarding.complete';

/// A one-screen welcome — no account, no name, no birthdate collected.
/// See the plan's "keep PII collection near zero" call.
class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              CivixTheme.accents[0].withValues(alpha: 0.22),
              theme.colorScheme.surface,
              CivixTheme.accents[1].withValues(alpha: 0.16),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 2),
                Container(
                  height: 76,
                  width: 76,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      colors: [CivixTheme.accents[0], CivixTheme.accents[1]],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(Icons.bolt_rounded, size: 44, color: Colors.white),
                )
                    .animate()
                    .scaleXY(begin: 0.6, end: 1, duration: 500.ms, curve: Curves.elasticOut)
                    .fadeIn(duration: 300.ms),
                const SizedBox(height: 28),
                Text('Civix', style: theme.textTheme.displaySmall)
                    .animate()
                    .fadeIn(delay: 150.ms, duration: 400.ms)
                    .slideX(begin: -0.06, end: 0),
                const SizedBox(height: 14),
                Text(
                  'Five short, sourced stories on what actually happened in '
                  'politics this week.',
                  style: theme.textTheme.bodyLarge?.copyWith(fontSize: 19, height: 1.4),
                ).animate().fadeIn(delay: 250.ms, duration: 400.ms),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    _Pill(icon: Icons.timer_outlined, text: 'About 4 minutes'),
                    _Pill(icon: Icons.balance_rounded, text: 'No team to root for'),
                    _Pill(icon: Icons.link_rounded, text: 'Every claim sourced'),
                  ],
                ).animate().fadeIn(delay: 380.ms, duration: 400.ms).slideY(begin: 0.15, end: 0),
                const Spacer(flex: 3),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => _finishOnboarding(context, ref, enableNotifications: true),
                    child: const Text('Turn on a daily reminder'),
                  ),
                ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2, end: 0),
                const SizedBox(height: 6),
                Center(
                  child: TextButton(
                    onPressed: () => _finishOnboarding(context, ref, enableNotifications: false),
                    child: const Text('Not now'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _finishOnboarding(
    BuildContext context,
    WidgetRef ref, {
    required bool enableNotifications,
  }) async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.setBool(kOnboardingCompleteKey, true);

    if (enableNotifications) {
      await ref.read(notificationSettingsProvider.notifier).updateSettings(
            enabled: true,
            time: const TimeOfDayValue(hour: 18, minute: 0),
          );
    }

    if (context.mounted) context.go('/today');
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: theme.colorScheme.primary),
          const SizedBox(width: 7),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
        ],
      ),
    );
  }
}
