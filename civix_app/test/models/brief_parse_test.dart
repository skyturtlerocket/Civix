import 'dart:convert';
import 'dart:io';

import 'package:civix_app/data/models/brief.dart';
import 'package:flutter_test/flutter_test.dart';

/// Parses the two hand-written fixture briefs straight off disk (not the
/// bundled asset copy) so this test fails immediately if the Dart models
/// drift from schema/brief.schema.json, without needing a widget harness.
void main() {
  final fixturesDir = Directory('../fixtures');

  test('fixtures directory exists at the expected relative path', () {
    expect(fixturesDir.existsSync(), isTrue,
        reason: 'expected ../fixtures relative to civix_app/');
  });

  for (final name in ['2026-09-01.json', '2026-08-31.json']) {
    test('parses $name into a Brief with all stories intact', () {
      final raw = File('${fixturesDir.path}/$name').readAsStringSync();
      final json = jsonDecode(raw) as Map<String, dynamic>;

      final brief = Brief.fromJson(json);

      expect(brief.briefId, json['brief_id']);
      expect(brief.stories.length, (json['stories'] as List).length);

      for (final story in brief.stories) {
        expect(story.headline, isNotEmpty);
        expect(story.whatHappened.citations, isNotEmpty);
        expect(story.argument.sideA.text, isNotEmpty);
        expect(story.argument.sideB.text, isNotEmpty);
        expect(
          story.check.answerIndex,
          lessThan(story.check.options.length),
        );
      }

      // Round-trip: serialize back to JSON and re-parse.
      final roundTripped = Brief.fromJson(brief.toJson());
      expect(roundTripped.stories.length, brief.stories.length);
    });
  }
}
