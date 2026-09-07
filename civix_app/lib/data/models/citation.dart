import 'package:freezed_annotation/freezed_annotation.dart';

part 'citation.freezed.dart';
part 'citation.g.dart';

/// A single primary-source citation backing a claim in a story.
///
/// Mirrors `#/definitions/citation` in `schema/brief.schema.json`.
@freezed
abstract class Citation with _$Citation {
  const factory Citation({
    required String label,
    required String url,
    @JsonKey(name: 'cited_text') String? citedText,
  }) = _Citation;

  factory Citation.fromJson(Map<String, dynamic> json) =>
      _$CitationFromJson(json);
}
