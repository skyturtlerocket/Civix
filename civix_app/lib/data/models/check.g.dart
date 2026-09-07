// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Check _$CheckFromJson(Map<String, dynamic> json) => _Check(
  question: json['question'] as String,
  options: (json['options'] as List<dynamic>).map((e) => e as String).toList(),
  answerIndex: (json['answer_index'] as num).toInt(),
  explanation: json['explanation'] as String,
);

Map<String, dynamic> _$CheckToJson(_Check instance) => <String, dynamic>{
  'question': instance.question,
  'options': instance.options,
  'answer_index': instance.answerIndex,
  'explanation': instance.explanation,
};
