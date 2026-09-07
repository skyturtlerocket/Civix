import 'package:freezed_annotation/freezed_annotation.dart';

part 'check.freezed.dart';
part 'check.g.dart';

/// A single comprehension question closing out a story.
///
/// Deliberately tests recall of what happened, never opinion — the app
/// never rewards agreeing with a position, only understanding it.
@freezed
abstract class Check with _$Check {
  const factory Check({
    required String question,
    required List<String> options,
    @JsonKey(name: 'answer_index') required int answerIndex,
    required String explanation,
  }) = _Check;

  factory Check.fromJson(Map<String, dynamic> json) => _$CheckFromJson(json);
}
