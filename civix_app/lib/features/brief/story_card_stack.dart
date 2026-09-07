import 'package:flutter/material.dart';

import '../../data/models/brief.dart';
import 'story_card.dart';

/// The whole day's brief as a vertically swipeable stack of [StoryCard]s
/// — the finite, ~4-minute daily habit loop the plan is built around.
class StoryCardStack extends StatefulWidget {
  const StoryCardStack({
    super.key,
    required this.brief,
    required this.onStoryChecked,
    required this.onAllStoriesComplete,
  });

  final Brief brief;

  /// storyId, whether the reader answered correctly.
  final void Function(String storyId, bool correct) onStoryChecked;

  final VoidCallback onAllStoriesComplete;

  @override
  State<StoryCardStack> createState() => _StoryCardStackState();
}

class _StoryCardStackState extends State<StoryCardStack> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stories = widget.brief.stories;
    return PageView(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      children: [
        for (var i = 0; i < stories.length; i++)
          StoryCard(
            story: stories[i],
            onChecked: (correct) => widget.onStoryChecked(stories[i].id, correct),
            onAdvanceToNextStory: () {
              final isLastStory = i == stories.length - 1;
              if (isLastStory) {
                widget.onAllStoriesComplete();
              } else {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              }
            },
          ),
      ],
    );
  }
}
