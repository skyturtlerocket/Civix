import 'package:freezed_annotation/freezed_annotation.dart';

import 'argument.dart';
import 'check.dart';
import 'review_info.dart';
import 'sourced_text.dart';

part 'story.freezed.dart';
part 'story.g.dart';

/// One card in a daily brief: a single political event, told through four
/// swipeable panels (what happened, why it matters, the argument, a
/// comprehension check). See `schema/brief.schema.json` for the wire
/// format this mirrors.
@freezed
abstract class Story with _$Story {
  const factory Story({
    required String id,
    required String headline,
    required List<String> topics,
    @JsonKey(name: 'what_happened') required SourcedText whatHappened,
    @JsonKey(name: 'why_it_matters') required SourcedText whyItMatters,
    required Argument argument,
    required Check check,
    ReviewInfo? review,
  }) = _Story;

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}
