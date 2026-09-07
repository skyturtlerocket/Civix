// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'citation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Citation _$CitationFromJson(Map<String, dynamic> json) => _Citation(
  label: json['label'] as String,
  url: json['url'] as String,
  citedText: json['cited_text'] as String?,
);

Map<String, dynamic> _$CitationToJson(_Citation instance) => <String, dynamic>{
  'label': instance.label,
  'url': instance.url,
  'cited_text': instance.citedText,
};
