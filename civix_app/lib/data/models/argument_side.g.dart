// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'argument_side.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ArgumentSide _$ArgumentSideFromJson(Map<String, dynamic> json) =>
    _ArgumentSide(
      label: json['label'] as String,
      text: json['text'] as String,
      wordCount: (json['word_count'] as num).toInt(),
    );

Map<String, dynamic> _$ArgumentSideToJson(_ArgumentSide instance) =>
    <String, dynamic>{
      'label': instance.label,
      'text': instance.text,
      'word_count': instance.wordCount,
    };
