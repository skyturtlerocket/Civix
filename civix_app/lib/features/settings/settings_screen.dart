import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/local/notifications.dart';
import 'notification_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(notificationSettingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          settingsAsync.when(
            data: (settings) => SwitchListTile(
              title: const Text('Daily reminder'),
              subtitle: Text(
                settings.enabled
                    ? _formatTime(settings.time)
                    : 'Off',
              ),
              value: settings.enabled,
              onChanged: (enabled) {
                ref.read(notificationSettingsProvider.notifier).updateSettings(
                      enabled: enabled,
                      time: settings.time,
                    );
              },
            ),
            loading: () => const ListTile(title: Text('Daily reminder'), subtitle: Text('Loading…')),
            error: (_, _) => const ListTile(title: Text('Daily reminder'), subtitle: Text('Unavailable')),
          ),
          if (settingsAsync.value?.enabled ?? false)
            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text('Reminder time'),
              subtitle: Text(_formatTime(settingsAsync.value!.time)),
              onTap: () => _pickTime(context, ref, settingsAsync.value!.time),
            ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.policy_outlined),
            title: const Text('How Civix works'),
            subtitle: const Text('Our methodology and how to flag bias'),
            onTap: () => context.push('/methodology'),
          ),
        ],
      ),
    );
  }

  String _formatTime(TimeOfDayValue t) {
    final hour12 = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final period = t.hour < 12 ? 'AM' : 'PM';
    final minute = t.minute.toString().padLeft(2, '0');
    return '$hour12:$minute $period';
  }

  Future<void> _pickTime(BuildContext context, WidgetRef ref, TimeOfDayValue current) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: current.hour, minute: current.minute),
    );
    if (picked == null) return;
    await ref.read(notificationSettingsProvider.notifier).updateSettings(
          enabled: true,
          time: TimeOfDayValue(hour: picked.hour, minute: picked.minute),
        );
  }
}
