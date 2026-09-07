/// Pure streak arithmetic — no Flutter, no persistence, no Riverpod.
/// Kept separate from [ProgressStore] specifically so the rollover/freeze/
/// timezone rules can be unit tested as plain Dart, per the plan's
/// verification section.
library;

/// Normalizes a [DateTime] to a local calendar date (midnight, no time
/// component) so streak math only ever compares dates, never instants.
DateTime asLocalDate(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

/// The Monday that starts the ISO week containing [date] — used to cap
/// streak freezes at one per week.
DateTime isoWeekStart(DateTime date) {
  final d = asLocalDate(date);
  // DateTime.weekday: Monday = 1 ... Sunday = 7.
  return d.subtract(Duration(days: d.weekday - 1));
}

class StreakState {
  const StreakState({
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastCompletedDate,
    this.freezesAvailable = 0,
    this.lastFreezeGrantedWeekStart,
    this.totalXp = 0,
  });

  final int currentStreak;
  final int longestStreak;
  final DateTime? lastCompletedDate;
  final int freezesAvailable;
  final DateTime? lastFreezeGrantedWeekStart;
  final int totalXp;

  StreakState copyWith({
    int? currentStreak,
    int? longestStreak,
    DateTime? lastCompletedDate,
    int? freezesAvailable,
    DateTime? lastFreezeGrantedWeekStart,
    int? totalXp,
  }) {
    return StreakState(
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastCompletedDate: lastCompletedDate ?? this.lastCompletedDate,
      freezesAvailable: freezesAvailable ?? this.freezesAvailable,
      lastFreezeGrantedWeekStart:
          lastFreezeGrantedWeekStart ?? this.lastFreezeGrantedWeekStart,
      totalXp: totalXp ?? this.totalXp,
    );
  }
}

const int maxFreezesPerWeek = 1;

/// Grants a weekly streak freeze if [today]'s ISO week hasn't already
/// received one. Idempotent — safe to call on every app open.
StreakState grantWeeklyFreezeIfDue(StreakState state, DateTime today) {
  final weekStart = isoWeekStart(today);
  final alreadyGrantedThisWeek = state.lastFreezeGrantedWeekStart != null &&
      state.lastFreezeGrantedWeekStart!.isAtSameMomentAs(weekStart);

  if (alreadyGrantedThisWeek || state.freezesAvailable >= maxFreezesPerWeek) {
    return state;
  }

  return state.copyWith(
    freezesAvailable: state.freezesAvailable + 1,
    lastFreezeGrantedWeekStart: weekStart,
  );
}

/// Applies one day's brief completion to [state]. Idempotent for repeat
/// calls on the same [today] (finishing all 5 stories doesn't double up
/// if somehow triggered twice). A one-day gap consumes a freeze if one is
/// available; any larger gap resets the streak to 1.
StreakState applyDayCompleted(StreakState state, DateTime rawToday) {
  final today = asLocalDate(rawToday);
  final last = state.lastCompletedDate;

  if (last != null && last.isAtSameMomentAs(today)) {
    return state; // already completed today — no-op
  }

  int newStreak;
  int freezesAvailable = state.freezesAvailable;

  if (last == null) {
    newStreak = 1;
  } else {
    final gapDays = today.difference(last).inDays;
    if (gapDays == 1) {
      newStreak = state.currentStreak + 1;
    } else if (gapDays == 2 && state.freezesAvailable > 0) {
      // One missed day, bridged by a freeze.
      newStreak = state.currentStreak + 1;
      freezesAvailable -= 1;
    } else {
      newStreak = 1;
    }
  }

  return state.copyWith(
    currentStreak: newStreak,
    longestStreak: newStreak > state.longestStreak ? newStreak : state.longestStreak,
    lastCompletedDate: today,
    freezesAvailable: freezesAvailable,
  );
}
