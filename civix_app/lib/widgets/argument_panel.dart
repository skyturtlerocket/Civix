import 'package:flutter/material.dart';

import '../data/models/argument.dart';
import '../data/models/argument_side.dart';

/// Renders a story's two-sided argument as a pair of boxes that are
/// **guaranteed identical in size**, regardless of which side's text is
/// longer. This symmetry is a bias control, not a style choice — see the
/// plan's "design rule with teeth." Enforced here by having a single
/// [_SideBox] widget lay out both sides inside an [IntrinsicHeight] row,
/// and verified by test/widgets/argument_panel_golden_test.dart.
class ArgumentPanel extends StatelessWidget {
  const ArgumentPanel({super.key, required this.argument});

  final Argument argument;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: _SideBox(side: argument.sideA)),
          const SizedBox(width: 12),
          Expanded(child: _SideBox(side: argument.sideB)),
        ],
      ),
    );
  }
}

class _SideBox extends StatelessWidget {
  const _SideBox({required this.side});

  final ArgumentSide side;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(12),
        // Both boxes always use the same neutral surface — never a
        // side-coded color (e.g. never red/blue).
        color: theme.colorScheme.surfaceContainerLow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            side.label,
            style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(side.text, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
