// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brief.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Brief _$BriefFromJson(Map<String, dynamic> json) => _Brief(
  briefId: json['brief_id'] as String,
  publishedAt: DateTime.parse(json['published_at'] as String),
  schemaVersion: (json['schema_version'] as num).toInt(),
  stories: (json['stories'] as List<dynamic>)
      .map((e) => Story.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BriefToJson(_Brief instance) => <String, dynamic>{
  'brief_id': instance.briefId,
  'published_at': instance.publishedAt.toIso8601String(),
  'schema_version': instance.schemaVersion,
  'stories': instance.stories.map((e) => e.toJson()).toList(),
};
