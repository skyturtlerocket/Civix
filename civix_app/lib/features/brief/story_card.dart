import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../app/topic_style.dart';
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
    this.storyNumber,
    this.storyCount,
  });

  final Story story;

  /// Called exactly once, the first time the reader answers this story's
  /// check — `correct` reports whether they got it right.
  final void Function(bool correct) onChecked;

  /// Shown as a button once the check panel is reached, if provided —
  /// lets [StoryCardStack] move to the next story without a manual swipe.
  final VoidCallback? onAdvanceToNextStory;

  /// 1-based position in the day's brief, shown as "story 2 of 5".
  final int? storyNumber;
  final int? storyCount;

  @override
  State<StoryCard> createState() => _StoryCardState();
}

class _StoryCardState extends State<StoryCard> {
  final _pageController = PageController();
  int _page = 0;
  bool _reportedThisStory = false;

  static const _panelLabels = ['What happened', 'Why it matters', 'Both sides', 'Quick check'];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final story = widget.story;
    final topic = TopicStyle.forStory(story.topics);

    final panels = <Widget>[
      SourcedTextPanel(heading: 'What happened', content: story.whatHappened, accent: topic.color),
      SourcedTextPanel(heading: 'Why it matters', content: story.whyItMatters, accent: topic.color),
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
        _Header(story: story, topic: topic, number: widget.storyNumber, count: widget.storyCount),
        _SegmentedProgress(count: panels.length, current: _page, color: topic.color),
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (i) => setState(() => _page = i),
            children: [
              for (var i = 0; i < panels.length; i++)
                SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                  // Re-keyed per page so the entrance animation replays as
                  // the reader moves through the story rather than firing
                  // once and never again.
                  child: Column(
                    key: ValueKey('${story.id}-$i'),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _panelLabels[i].toUpperCase(),
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: topic.color,
                          fontSize: 11.5,
                        ),
                      ),
                      const SizedBox(height: 14),
                      panels[i],
                    ],
                  )
                      .animate()
                      .fadeIn(duration: 260.ms)
                      .slideY(begin: 0.06, end: 0, curve: Curves.easeOutCubic),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
          child: _bottomButton(panels.length, topic),
        ),
      ],
    );
  }

  Widget _bottomButton(int panelCount, TopicStyle topic) {
    final isLastPanel = _page == panelCount - 1;
    if (isLastPanel) {
      if (widget.onAdvanceToNextStory == null) {
        return const SizedBox.shrink();
      }
      return SizedBox(
        width: double.infinity,
        child: FilledButton.icon(
          onPressed: widget.onAdvanceToNextStory,
          style: FilledButton.styleFrom(backgroundColor: topic.color, foregroundColor: Colors.black),
          icon: const Icon(Icons.arrow_forward_rounded),
          label: const Text('Next story'),
        ),
      ).animate().fadeIn(duration: 200.ms).scaleXY(begin: 0.96, end: 1);
    }
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _pageController.nextPage(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
        ),
        icon: const Icon(Icons.arrow_forward_rounded),
        label: const Text('Continue'),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.story, required this.topic, this.number, this.count});

  final Story story;
  final TopicStyle topic;
  final int? number;
  final int? count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
      decoration: BoxDecoration(
        // A wash of the topic colour behind the headline — enough to give
        // each story its own identity without tinting the body text.
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [topic.color.withValues(alpha: 0.20), topic.color.withValues(alpha: 0.02)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TopicChip(style: topic),
              const Spacer(),
              if (number != null && count != null)
                Text(
                  '$number of $count',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(story.headline, style: theme.textTheme.headlineSmall),
        ],
      ),
    );
  }
}

/// Four chunky segments that fill as the reader moves through the story —
/// the "you're making progress" signal the old 8px dots didn't give.
class _SegmentedProgress extends StatelessWidget {
  const _SegmentedProgress({required this.count, required this.current, required this.color});

  final int count;
  final int current;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Row(
        children: [
          for (var i = 0; i < count; i++)
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 320),
                curve: Curves.easeOutCubic,
                height: 5,
                margin: EdgeInsets.only(right: i == count - 1 ? 0 : 5),
                decoration: BoxDecoration(
                  color: i <= current ? color : color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
