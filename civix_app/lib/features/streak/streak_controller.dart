import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/local/progress_store.dart';
import 'streak_logic.dart';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) {
  return SharedPreferences.getInstance();
});

final progressStoreProvider = FutureProvider<ProgressStore>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return ProgressStore(prefs);
});

/// Owns [StreakState] and every place it can change: the weekly freeze
/// grant (checked on load) and a day being completed. UI reads this via
/// [streakControllerProvider] and never touches [ProgressStore] directly.
class StreakController extends AsyncNotifier<StreakState> {
  ProgressStore? _store;

  @override
  Future<StreakState> build() async {
    final store = await ref.watch(progressStoreProvider.future);
    _store = store;

    var streak = store.readStreak();
    final granted = grantWeeklyFreezeIfDue(streak, DateTime.now());
    if (!identical(granted, streak)) {
      await store.writeStreak(granted);
      streak = granted;
    }
    return streak;
  }

  /// Call once a brief's every story has been completed for the day.
  /// Idempotent — safe to call again if the last story is re-completed.
  Future<void> markDayCompleted() async {
    final store = _store;
    if (store == null) return;

    final current = state.value ?? store.readStreak();
    final updated = applyDayCompleted(current, DateTime.now());
    await store.writeStreak(updated);
    state = AsyncData(updated);
  }

  /// XP for finishing a story; [correct] adds the comprehension bonus.
  /// [alreadyAwarded] guards against re-awarding XP when a reader revisits
  /// a story they already completed today.
  Future<void> awardXp({required bool correct, required bool alreadyAwarded}) async {
    if (alreadyAwarded) return;
    final store = _store;
    if (store == null) return;

    const baseXp = 10;
    const correctBonus = 5;
    final current = state.value ?? store.readStreak();
    final updated = current.copyWith(
      totalXp: current.totalXp + baseXp + (correct ? correctBonus : 0),
    );
    await store.writeStreak(updated);
    state = AsyncData(updated);
  }
}

final streakControllerProvider =
    AsyncNotifierProvider<StreakController, StreakState>(StreakController.new);
