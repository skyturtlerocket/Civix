import 'package:freezed_annotation/freezed_annotation.dart';

import 'story.dart';

part 'brief.freezed.dart';
part 'brief.g.dart';

/// A full daily brief: a fixed set of stories published for one date.
///
/// Mirrors the top level of `schema/brief.schema.json`. [briefId] is the
/// ISO date the brief was published for (e.g. "2026-09-01"), used as the
/// cache key and the archive sort key.
@freezed
abstract class Brief with _$Brief {
  const factory Brief({
    @JsonKey(name: 'brief_id') required String briefId,
    @JsonKey(name: 'published_at') required DateTime publishedAt,
    @JsonKey(name: 'schema_version') required int schemaVersion,
    required List<Story> stories,
  }) = _Brief;

  factory Brief.fromJson(Map<String, dynamic> json) => _$BriefFromJson(json);
}
