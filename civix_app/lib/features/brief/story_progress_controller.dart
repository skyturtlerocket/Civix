import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/progress_store.dart';
import '../../data/models/brief.dart';
import '../streak/streak_controller.dart';

/// Tracks which stories in one brief (keyed by [briefId]) have been
/// completed, backed by [ProgressStore] so progress survives an app kill
/// mid-brief. Completing the brief's last story rolls the day into the
/// streak automatically.
class StoryProgressController extends AsyncNotifier<Set<String>> {
  StoryProgressController(this.briefId);

  final String briefId;
  ProgressStore? _store;

  @override
  Future<Set<String>> build() async {
    final store = await ref.watch(progressStoreProvider.future);
    _store = store;
    return store.completedStoryIds(briefId);
  }

  Future<void> completeStory({
    required String storyId,
    required bool correctAnswer,
    required int totalStoriesInBrief,
  }) async {
    final store = _store;
    if (store == null) return;

    final before = state.value ?? store.completedStoryIds(briefId);
    final alreadyDone = before.contains(storyId);

    if (!alreadyDone) {
      await store.markStoryCompleted(briefId, storyId);
    }
    if (correctAnswer && !store.correctlyCheckedStoryIds(briefId).contains(storyId)) {
      await store.markCheckCorrect(briefId, storyId);
    }

    await ref.read(streakControllerProvider.notifier).awardXp(
          correct: correctAnswer,
          alreadyAwarded: alreadyDone,
        );

    final after = store.completedStoryIds(briefId);
    state = AsyncData(after);

    if (after.length >= totalStoriesInBrief && !alreadyDone) {
      await ref.read(streakControllerProvider.notifier).markDayCompleted();
    }
  }
}

final storyProgressProvider =
    AsyncNotifierProvider.family<StoryProgressController, Set<String>, String>(
  (briefId) => StoryProgressController(briefId),
);

/// Convenience: is every story in [brief] complete?
bool briefIsComplete(Brief brief, Set<String> completedIds) {
  return brief.stories.every((s) => completedIds.contains(s.id));
}
