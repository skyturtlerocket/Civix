import 'package:freezed_annotation/freezed_annotation.dart';

import 'citation.dart';

part 'sourced_text.freezed.dart';
part 'sourced_text.g.dart';

/// A block of prose (e.g. "What happened") paired with the citations that
/// ground it. Every factual sentence in [text] should trace back to at
/// least one entry in [citations] — enforced upstream by the pipeline's
/// citation-coverage gate, not by this model.
@freezed
abstract class SourcedText with _$SourcedText {
  const factory SourcedText({
    required String text,
    required List<Citation> citations,
  }) = _SourcedText;

  factory SourcedText.fromJson(Map<String, dynamic> json) =>
      _$SourcedTextFromJson(json);
}
