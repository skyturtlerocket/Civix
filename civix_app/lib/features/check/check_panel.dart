import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../app/theme.dart';
import '../streak/streak_controller.dart';
import '../../data/models/check.dart';

/// One comprehension question closing out a story. Deliberately tests
/// recall of what happened, never opinion — see [Check]'s doc comment.
/// Reports the answer back via [onAnswered] and never blocks the reader
/// from moving on regardless of whether they got it right.
///
/// A wrong answer is styled as a nudge (amber, "not quite") rather than a
/// failure (red, a cross). The check exists to make the reader re-read the
/// card, not to score them, so nothing here punishes a miss.
class CheckPanel extends StatefulWidget {
  const CheckPanel({super.key, required this.check, required this.onAnswered});

  final Check check;
  final void Function(bool correct) onAnswered;

  @override
  State<CheckPanel> createState() => _CheckPanelState();
}

class _CheckPanelState extends State<CheckPanel> {
  int? _selectedIndex;

  bool get _answered => _selectedIndex != null;
  bool get _gotItRight => _selectedIndex == widget.check.answerIndex;

  void _choose(int index) {
    setState(() => _selectedIndex = index);
    final correct = index == widget.check.answerIndex;
    // A short haptic on answer — the one piece of physical feedback in the
    // app, and the moment it makes most sense.
    correct ? HapticFeedback.mediumImpact() : HapticFeedback.selectionClick();
    widget.onAnswered(correct);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final check = widget.check;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(check.question, style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 19,
              height: 1.35,
            )),
        const SizedBox(height: 18),
        for (var i = 0; i < check.options.length; i++) _optionTile(context, i),
        if (_answered) ...[
          const SizedBox(height: 16),
          _ResultBanner(correct: _gotItRight),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(check.explanation, style: theme.textTheme.bodyMedium),
          )
              .animate()
              .fadeIn(duration: 300.ms, delay: 120.ms)
              .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic),
        ],
      ],
    );
  }

  Widget _optionTile(BuildContext context, int index) {
    final theme = Theme.of(context);
    final check = widget.check;
    final isCorrect = index == check.answerIndex;
    final isSelected = index == _selectedIndex;

    Color border = theme.colorScheme.outlineVariant;
    Color fill = theme.colorScheme.surfaceContainerLow;
    Widget? trailing;

    if (_answered && isCorrect) {
      border = CivixTheme.correct;
      fill = CivixTheme.correct.withValues(alpha: 0.14);
      trailing = const Icon(Icons.check_circle_rounded, color: CivixTheme.correct);
    } else if (_answered && isSelected) {
      border = CivixTheme.nudge;
      fill = CivixTheme.nudge.withValues(alpha: 0.14);
      trailing = const Icon(Icons.refresh_rounded, color: CivixTheme.nudge);
    }

    final tile = AnimatedContainer(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOut,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border, width: _answered && (isCorrect || isSelected) ? 2 : 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: _answered ? null : () => _choose(index),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    check.options[index],
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.5,
                    ),
                  ),
                ),
                if (trailing != null) ...[const SizedBox(width: 10), trailing],
              ],
            ),
          ),
        ),
      ),
    );

    // The chosen tile reacts; the others just settle.
    if (_answered && isSelected) {
      return isCorrect
          ? tile.animate().scaleXY(begin: 1, end: 1.03, duration: 140.ms).then().scaleXY(end: 1)
          : tile.animate().shakeX(hz: 3.5, amount: 2, duration: 320.ms);
    }
    return tile;
  }
}

/// The XP shown here is the exact amount [StreakController.awardXp] will
/// credit — a wrong answer still earns the base story XP, so the number is
/// never zero and never a lie.
class _ResultBanner extends StatelessWidget {
  const _ResultBanner({required this.correct});

  final bool correct;

  @override
  Widget build(BuildContext context) {
    final color = correct ? CivixTheme.correct : CivixTheme.nudge;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Icon(correct ? Icons.bolt_rounded : Icons.lightbulb_outline_rounded, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              correct ? 'Nice — you got it.' : 'Not quite — here\'s why.',
              style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 15),
            ),
          ),
          Text(
            '+${kBaseStoryXp + (correct ? kCorrectAnswerBonusXp : 0)} XP',
            style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 15),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 260.ms)
        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutBack);
  }
}
