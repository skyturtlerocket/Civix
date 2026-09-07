import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/streak/streak_logic.dart';

/// Persists [StreakState] plus per-brief completion progress to
/// SharedPreferences. This — not the Drift cache — is the single source
/// of truth for "how far has this reader gotten," since it must survive
/// an app kill mid-story (see the plan's app verification steps).
class ProgressStore {
  ProgressStore(this._prefs);

  static const _kCurrentStreak = 'streak.current';
  static const _kLongestStreak = 'streak.longest';
  static const _kLastCompletedDate = 'streak.last_completed_date';
  static const _kFreezesAvailable = 'streak.freezes_available';
  static const _kLastFreezeWeek = 'streak.last_freeze_week';
  static const _kTotalXp = 'streak.total_xp';
  static const _kCompletedStoriesPrefix = 'progress.completed.'; // + briefId
  static const _kCorrectChecksPrefix = 'progress.correct.'; // + briefId

  final SharedPreferences _prefs;

  StreakState readStreak() {
    final lastDateStr = _prefs.getString(_kLastCompletedDate);
    final lastFreezeWeekStr = _prefs.getString(_kLastFreezeWeek);
    return StreakState(
      currentStreak: _prefs.getInt(_kCurrentStreak) ?? 0,
      longestStreak: _prefs.getInt(_kLongestStreak) ?? 0,
      lastCompletedDate: lastDateStr != null ? DateTime.parse(lastDateStr) : null,
      freezesAvailable: _prefs.getInt(_kFreezesAvailable) ?? 0,
      lastFreezeGrantedWeekStart:
          lastFreezeWeekStr != null ? DateTime.parse(lastFreezeWeekStr) : null,
      totalXp: _prefs.getInt(_kTotalXp) ?? 0,
    );
  }

  Future<void> writeStreak(StreakState state) async {
    await _prefs.setInt(_kCurrentStreak, state.currentStreak);
    await _prefs.setInt(_kLongestStreak, state.longestStreak);
    if (state.lastCompletedDate != null) {
      await _prefs.setString(
        _kLastCompletedDate,
        state.lastCompletedDate!.toIso8601String(),
      );
    }
    await _prefs.setInt(_kFreezesAvailable, state.freezesAvailable);
    if (state.lastFreezeGrantedWeekStart != null) {
      await _prefs.setString(
        _kLastFreezeWeek,
        state.lastFreezeGrantedWeekStart!.toIso8601String(),
      );
    }
    await _prefs.setInt(_kTotalXp, state.totalXp);
  }

  /// Story ids completed so far within [briefId] — survives an app kill
  /// mid-brief, so reopening resumes exactly where the reader left off.
  Set<String> completedStoryIds(String briefId) {
    final raw = _prefs.getString('$_kCompletedStoriesPrefix$briefId');
    if (raw == null) return {};
    return Set<String>.from(jsonDecode(raw) as List);
  }

  Future<void> markStoryCompleted(String briefId, String storyId) async {
    final current = completedStoryIds(briefId)..add(storyId);
    await _prefs.setString(
      '$_kCompletedStoriesPrefix$briefId',
      jsonEncode(current.toList()),
    );
  }

  /// Which of a brief's checks were answered correctly — used only to
  /// avoid double-counting the correct-answer XP bonus if a reader
  /// revisits a story they've already completed.
  Set<String> correctlyCheckedStoryIds(String briefId) {
    final raw = _prefs.getString('$_kCorrectChecksPrefix$briefId');
    if (raw == null) return {};
    return Set<String>.from(jsonDecode(raw) as List);
  }

  Future<void> markCheckCorrect(String briefId, String storyId) async {
    final current = correctlyCheckedStoryIds(briefId)..add(storyId);
    await _prefs.setString(
      '$_kCorrectChecksPrefix$briefId',
      jsonEncode(current.toList()),
    );
  }
}
