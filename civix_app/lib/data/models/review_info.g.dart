// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReviewInfo _$ReviewInfoFromJson(Map<String, dynamic> json) => _ReviewInfo(
  approvedAt: DateTime.parse(json['approved_at'] as String),
  edited: json['edited'] as bool,
);

Map<String, dynamic> _$ReviewInfoToJson(_ReviewInfo instance) =>
    <String, dynamic>{
      'approved_at': instance.approvedAt.toIso8601String(),
      'edited': instance.edited,
    };
