import 'package:flutter/material.dart';

import '../../data/models/story.dart';
import '../../widgets/argument_panel.dart';
import '../../widgets/sourced_text_panel.dart';
import '../check/check_panel.dart';

/// One story told across four swipeable panels: what happened, why it
/// matters, the two-sided argument, and a comprehension check — the
/// sequence described in the plan's "story card stack" section.
class StoryCard extends StatefulWidget {
  const StoryCard({
    super.key,
    required this.story,
    required this.onChecked,
    this.onAdvanceToNextStory,
  });

  final Story story;

  /// Called exactly once, the first time the reader answers this story's
  /// check — `correct` reports whether they got it right.
  final void Function(bool correct) onChecked;

  /// Shown as a button once the check panel is reached, if provided —
  /// lets [StoryCardStack] move to the next story without a manual swipe.
  final VoidCallback? onAdvanceToNextStory;

  @override
  State<StoryCard> createState() => _StoryCardState();
}

class _StoryCardState extends State<StoryCard> {
  final _pageController = PageController();
  int _page = 0;
  bool _reportedThisStory = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final story = widget.story;
    final panels = <Widget>[
      SourcedTextPanel(heading: 'What happened', content: story.whatHappened),
      SourcedTextPanel(heading: 'Why it matters', content: story.whyItMatters),
      ArgumentPanel(argument: story.argument),
      CheckPanel(
        check: story.check,
        onAnswered: (correct) {
          if (_reportedThisStory) return;
          _reportedThisStory = true;
          widget.onChecked(correct);
        },
      ),
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            story.headline,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (i) => setState(() => _page = i),
            children: [
              for (final panel in panels)
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: panel,
                ),
            ],
          ),
        ),
        _PageDots(count: panels.length, current: _page),
        Padding(
          padding: const EdgeInsets.all(16),
          child: _bottomButton(panels.length),
        ),
      ],
    );
  }

  Widget _bottomButton(int panelCount) {
    final isLastPanel = _page == panelCount - 1;
    if (isLastPanel) {
      if (widget.onAdvanceToNextStory == null) {
        return const SizedBox.shrink();
      }
      return FilledButton.icon(
        onPressed: widget.onAdvanceToNextStory,
        icon: const Icon(Icons.arrow_forward),
        label: const Text('Next story'),
      );
    }
    return OutlinedButton.icon(
      onPressed: () => _pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      ),
      icon: const Icon(Icons.arrow_forward),
      label: const Text('Continue'),
    );
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.current});

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: i == current ? color : color.withValues(alpha: 0.25),
            ),
          ),
      ],
    );
  }
}
