import 'package:freezed_annotation/freezed_annotation.dart';

import 'argument_side.dart';

part 'argument.freezed.dart';
part 'argument.g.dart';

/// A story's symmetric two-sided argument panel.
@freezed
abstract class Argument with _$Argument {
  const factory Argument({
    @JsonKey(name: 'side_a') required ArgumentSide sideA,
    @JsonKey(name: 'side_b') required ArgumentSide sideB,
  }) = _Argument;

  factory Argument.fromJson(Map<String, dynamic> json) =>
      _$ArgumentFromJson(json);
}
