import 'package:flutter/material.dart';

import '../../data/models/check.dart';

/// One comprehension question closing out a story. Deliberately tests
/// recall of what happened, never opinion — see [Check]'s doc comment.
/// Reports the answer back via [onAnswered] and never blocks the reader
/// from moving on regardless of whether they got it right.
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final check = widget.check;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Quick check', style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(check.question, style: theme.textTheme.bodyLarge),
        const SizedBox(height: 12),
        for (var i = 0; i < check.options.length; i++) _optionTile(context, i),
        if (_answered) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(check.explanation, style: theme.textTheme.bodyMedium),
          ),
        ],
      ],
    );
  }

  Widget _optionTile(BuildContext context, int index) {
    final theme = Theme.of(context);
    final check = widget.check;
    final isCorrect = index == check.answerIndex;
    final isSelected = index == _selectedIndex;

    Color? tileColor;
    IconData? trailingIcon;
    if (_answered && isSelected) {
      tileColor = isCorrect
          ? theme.colorScheme.primaryContainer
          : theme.colorScheme.errorContainer;
      trailingIcon = isCorrect ? Icons.check_circle : Icons.cancel;
    } else if (_answered && isCorrect) {
      // Reveal the correct answer even if the reader picked wrong.
      tileColor = theme.colorScheme.primaryContainer.withValues(alpha: 0.5);
      trailingIcon = Icons.check_circle_outline;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: tileColor,
      child: ListTile(
        title: Text(check.options[index]),
        trailing: trailingIcon != null ? Icon(trailingIcon) : null,
        onTap: _answered
            ? null
            : () {
                setState(() => _selectedIndex = index);
                widget.onAnswered(isCorrect);
              },
      ),
    );
  }
}
