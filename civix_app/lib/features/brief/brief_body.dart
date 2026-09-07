import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/brief.dart';
import '../streak/day_complete_celebration.dart';
import '../streak/streak_controller.dart';
import 'story_card_stack.dart';
import 'story_progress_controller.dart';

/// Shared body for "read this brief" — used by both [TodayScreen] (today's
/// brief) and the archive detail view (any past brief). Progress and the
/// streak are keyed by [brief.briefId], so re-reading a past brief never
/// double-counts toward today's streak.
class BriefBody extends ConsumerWidget {
  const BriefBody({super.key, required this.brief, this.isToday = false});

  final Brief brief;

  /// Only today's brief rolls into the streak on completion — see
  /// [StoryCardStack.onAllStoriesComplete] below.
  final bool isToday;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressAsync = ref.watch(storyProgressProvider(brief.briefId));

    return progressAsync.when(
      data: (completedIds) {
        if (briefIsComplete(brief, completedIds)) {
          return _AlreadyDoneState(brief: brief);
        }
        return StoryCardStack(
          brief: brief,
          onStoryChecked: (storyId, correct) {
            ref.read(storyProgressProvider(brief.briefId).notifier).completeStory(
                  storyId: storyId,
                  correctAnswer: correct,
                  totalStoriesInBrief: brief.stories.length,
                );
          },
          onAllStoriesComplete: () async {
            if (!isToday) {
              if (context.mounted) Navigator.of(context).maybePop();
              return;
            }
            final streak = ref.read(streakControllerProvider).value;
            if (streak != null && context.mounted) {
              await DayCompleteCelebration.show(context, streak);
            }
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => const Center(child: Text('Could not load your progress.')),
    );
  }
}

class _AlreadyDoneState extends StatelessWidget {
  const _AlreadyDoneState({required this.brief});

  final Brief brief;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, size: 48),
            const SizedBox(height: 12),
            Text(
              "You've finished this brief.",
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
