import 'package:civix_app/features/streak/streak_logic.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('applyDayCompleted', () {
    test('first ever completion starts a streak of 1', () {
      final state = applyDayCompleted(const StreakState(), DateTime(2026, 9, 1));
      expect(state.currentStreak, 1);
      expect(state.longestStreak, 1);
      expect(state.lastCompletedDate, DateTime(2026, 9, 1));
    });

    test('consecutive days increment the streak', () {
      var state = applyDayCompleted(const StreakState(), DateTime(2026, 9, 1));
      state = applyDayCompleted(state, DateTime(2026, 9, 2));
      state = applyDayCompleted(state, DateTime(2026, 9, 3));
      expect(state.currentStreak, 3);
      expect(state.longestStreak, 3);
    });

    test('completing twice on the same day is a no-op', () {
      var state = applyDayCompleted(const StreakState(), DateTime(2026, 9, 1));
      state = applyDayCompleted(state, DateTime(2026, 9, 1, 23, 59));
      expect(state.currentStreak, 1);
    });

    test('a same-day completion at a different time of day still counts as one day', () {
      var state = applyDayCompleted(const StreakState(), DateTime(2026, 9, 1, 8));
      state = applyDayCompleted(state, DateTime(2026, 9, 1, 22));
      expect(state.currentStreak, 1, reason: 'time-of-day must not affect date comparison');
    });

    test('a gap of two or more days with no freeze resets the streak to 1', () {
      var state = applyDayCompleted(const StreakState(), DateTime(2026, 9, 1));
      state = applyDayCompleted(state, DateTime(2026, 9, 4)); // 3-day gap
      expect(state.currentStreak, 1);
      expect(state.longestStreak, 1, reason: 'longest streak from before the reset is preserved');
    });

    test('longestStreak is preserved across a reset', () {
      var state = applyDayCompleted(const StreakState(), DateTime(2026, 9, 1));
      state = applyDayCompleted(state, DateTime(2026, 9, 2));
      state = applyDayCompleted(state, DateTime(2026, 9, 3)); // streak = 3
      state = applyDayCompleted(state, DateTime(2026, 9, 10)); // big gap, resets to 1
      expect(state.currentStreak, 1);
      expect(state.longestStreak, 3);
    });

    test('a one-day gap consumes an available freeze and continues the streak', () {
      var state = applyDayCompleted(const StreakState(), DateTime(2026, 9, 1));
      state = state.copyWith(freezesAvailable: 1);
      // Sept 2 missed entirely.
      state = applyDayCompleted(state, DateTime(2026, 9, 3));
      expect(state.currentStreak, 2, reason: 'freeze bridges the missed day');
      expect(state.freezesAvailable, 0, reason: 'the freeze is consumed');
    });

    test('a one-day gap with no freeze available resets the streak', () {
      var state = applyDayCompleted(const StreakState(), DateTime(2026, 9, 1));
      // freezesAvailable defaults to 0
      state = applyDayCompleted(state, DateTime(2026, 9, 3));
      expect(state.currentStreak, 1);
    });

    test('a freeze only bridges exactly a two-day gap, not longer', () {
      var state = applyDayCompleted(const StreakState(), DateTime(2026, 9, 1));
      state = state.copyWith(freezesAvailable: 1);
      state = applyDayCompleted(state, DateTime(2026, 9, 5)); // 4-day gap
      expect(state.currentStreak, 1, reason: 'a freeze covers one missed day, not three');
      expect(state.freezesAvailable, 1, reason: 'freeze is not spent on a gap it cannot cover');
    });
  });

  group('grantWeeklyFreezeIfDue', () {
    test('grants a freeze when none has been granted yet', () {
      final state = grantWeeklyFreezeIfDue(const StreakState(), DateTime(2026, 9, 1));
      expect(state.freezesAvailable, 1);
    });

    test('does not grant a second freeze in the same ISO week', () {
      var state = grantWeeklyFreezeIfDue(const StreakState(), DateTime(2026, 9, 1)); // Tue
      state = grantWeeklyFreezeIfDue(state, DateTime(2026, 9, 3)); // Thu, same week
      expect(state.freezesAvailable, 1);
    });

    test('grants a new freeze once a new ISO week starts', () {
      var state = grantWeeklyFreezeIfDue(const StreakState(), DateTime(2026, 9, 1)); // Tue
      state = state.copyWith(freezesAvailable: 0); // simulate last week's freeze being used
      state = grantWeeklyFreezeIfDue(state, DateTime(2026, 9, 8)); // following Tuesday
      expect(state.freezesAvailable, 1);
    });

    test('does not stack freezes beyond the weekly cap even if unused', () {
      var state = grantWeeklyFreezeIfDue(const StreakState(), DateTime(2026, 9, 1));
      state = grantWeeklyFreezeIfDue(state, DateTime(2026, 9, 8));
      state = grantWeeklyFreezeIfDue(state, DateTime(2026, 9, 15));
      expect(state.freezesAvailable, maxFreezesPerWeek);
    });
  });

  group('isoWeekStart', () {
    test('a Wednesday resolves to the Monday of the same week', () {
      expect(isoWeekStart(DateTime(2026, 9, 2)), DateTime(2026, 8, 31));
    });

    test('a Monday resolves to itself', () {
      expect(isoWeekStart(DateTime(2026, 8, 31)), DateTime(2026, 8, 31));
    });

    test('a Sunday resolves to the Monday that started its week', () {
      expect(isoWeekStart(DateTime(2026, 9, 6)), DateTime(2026, 8, 31));
    });
  });
}
