import 'package:freezed_annotation/freezed_annotation.dart';

part 'argument_side.freezed.dart';
part 'argument_side.g.dart';

/// One side of a story's steelmanned argument panel.
///
/// [label] is a position (e.g. "Supporters argue"), never a party — see
/// the "label by position, never by party" rule in the app design.
@freezed
abstract class ArgumentSide with _$ArgumentSide {
  const factory ArgumentSide({
    required String label,
    required String text,
    @JsonKey(name: 'word_count') required int wordCount,
  }) = _ArgumentSide;

  factory ArgumentSide.fromJson(Map<String, dynamic> json) =>
      _$ArgumentSideFromJson(json);
}
