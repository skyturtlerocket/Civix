import 'package:civix_app/data/models/argument.dart';
import 'package:civix_app/data/models/argument_side.dart';
import 'package:civix_app/widgets/argument_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// This is the test with teeth from the plan's "design rule with teeth":
/// the two argument boxes must render at identical height no matter which
/// side's text is longer.
///
/// Deliberately implemented as a rendered-size equality assertion rather
/// than a pixel-diff image golden — a size check directly tests the
/// actual invariant (symmetry) and stays stable across the font-hinting
/// and anti-aliasing differences that make image goldens flaky across
/// machines/CI, while still catching the regression a real designer would
/// care about (one box visibly taller than the other).
void main() {
  String wordsOfLength(String label, int n) {
    return List.generate(n, (i) => '${label}word$i').join(' ');
  }

  final textLengthPairs = <(String, String)>[
    (wordsOfLength('short', 20), wordsOfLength('short', 22)), // roughly equal, short
    (wordsOfLength('short', 25), wordsOfLength('long', 45)),  // imbalanced input text
    (wordsOfLength('long', 60), wordsOfLength('long', 65)),   // roughly equal, long
  ];

  final screenWidths = [360.0, 800.0]; // narrow phone, wide tablet

  for (final width in screenWidths) {
    for (var i = 0; i < textLengthPairs.length; i++) {
      final (sideAText, sideBText) = textLengthPairs[i];

      testWidgets(
        'both argument boxes render at equal height (case $i, width $width)',
        (tester) async {
          tester.view.physicalSize = Size(width, 2000);
          tester.view.devicePixelRatio = 1.0;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);

          final argument = Argument(
            sideA: ArgumentSide(
              label: 'Supporters argue',
              text: sideAText,
              wordCount: sideAText.split(' ').length,
            ),
            sideB: ArgumentSide(
              label: 'Opponents argue',
              text: sideBText,
              wordCount: sideBText.split(' ').length,
            ),
          );

          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: ArgumentPanel(argument: argument),
                ),
              ),
            ),
          );
          await tester.pumpAndSettle();

          final boxFinder = find.byWidgetPredicate((w) => w is Container && w.decoration != null);
          expect(boxFinder, findsNWidgets(2));

          final sizeA = tester.getSize(boxFinder.at(0));
          final sizeB = tester.getSize(boxFinder.at(1));

          expect(
            sizeA.height,
            closeTo(sizeB.height, 0.5),
            reason:
                'argument panel symmetry is a bias control — the two sides must '
                'render at the same height regardless of text length',
          );
        },
      );
    }
  }
}
