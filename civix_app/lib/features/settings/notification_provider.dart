import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/notifications.dart';
import '../streak/streak_controller.dart';

const _kNotificationHour = 'notifications.hour';
const _kNotificationMinute = 'notifications.minute';
const _kNotificationEnabled = 'notifications.enabled';

final notificationSchedulerProvider = FutureProvider<NotificationScheduler>((ref) {
  return NotificationScheduler.create();
});

class NotificationSettings {
  const NotificationSettings({required this.enabled, required this.time});

  final bool enabled;
  final TimeOfDayValue time;
}

class NotificationSettingsController extends AsyncNotifier<NotificationSettings> {
  @override
  Future<NotificationSettings> build() async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    return NotificationSettings(
      enabled: prefs.getBool(_kNotificationEnabled) ?? false,
      time: TimeOfDayValue(
        hour: prefs.getInt(_kNotificationHour) ?? 18,
        minute: prefs.getInt(_kNotificationMinute) ?? 0,
      ),
    );
  }

  Future<void> updateSettings({required bool enabled, required TimeOfDayValue time}) async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.setBool(_kNotificationEnabled, enabled);
    await prefs.setInt(_kNotificationHour, time.hour);
    await prefs.setInt(_kNotificationMinute, time.minute);

    final scheduler = await ref.read(notificationSchedulerProvider.future);
    if (enabled) {
      await scheduler.requestPermission();
      await scheduler.scheduleDaily(time);
    } else {
      await scheduler.cancel();
    }

    state = AsyncData(NotificationSettings(enabled: enabled, time: time));
  }
}

final notificationSettingsProvider =
    AsyncNotifierProvider<NotificationSettingsController, NotificationSettings>(
  NotificationSettingsController.new,
);
