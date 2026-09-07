import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_info.freezed.dart';
part 'review_info.g.dart';

/// Editorial metadata about a story's human approval — present on every
/// published story (the pipeline never publishes an unreviewed draft) but
/// modeled as optional here so app-side fixtures can omit it.
@freezed
abstract class ReviewInfo with _$ReviewInfo {
  const factory ReviewInfo({
    @JsonKey(name: 'approved_at') required DateTime approvedAt,
    required bool edited,
  }) = _ReviewInfo;

  factory ReviewInfo.fromJson(Map<String, dynamic> json) =>
      _$ReviewInfoFromJson(json);
}
