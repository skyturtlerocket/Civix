// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sourced_text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SourcedText _$SourcedTextFromJson(Map<String, dynamic> json) => _SourcedText(
  text: json['text'] as String,
  citations: (json['citations'] as List<dynamic>)
      .map((e) => Citation.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SourcedTextToJson(_SourcedText instance) =>
    <String, dynamic>{
      'text': instance.text,
      'citations': instance.citations.map((e) => e.toJson()).toList(),
    };
