import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_fire_department, size: 56),
              const SizedBox(height: 16),
              Text('Civix', style: theme.textTheme.headlineLarge),
              const SizedBox(height: 12),
              const Text(
                'Five short, sourced stories on what actually happened in '
                'politics this week — no team to root for, about four '
                'minutes a day.',
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              FilledButton(
                onPressed: () => _finishOnboarding(context, ref, enableNotifications: true),
                child: const Text('Turn on a daily reminder'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => _finishOnboarding(context, ref, enableNotifications: false),
                child: const Text('Not now'),
              ),
            ],
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
