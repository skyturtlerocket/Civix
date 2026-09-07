// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Story _$StoryFromJson(Map<String, dynamic> json) => _Story(
  id: json['id'] as String,
  headline: json['headline'] as String,
  topics: (json['topics'] as List<dynamic>).map((e) => e as String).toList(),
  whatHappened: SourcedText.fromJson(
    json['what_happened'] as Map<String, dynamic>,
  ),
  whyItMatters: SourcedText.fromJson(
    json['why_it_matters'] as Map<String, dynamic>,
  ),
  argument: Argument.fromJson(json['argument'] as Map<String, dynamic>),
  check: Check.fromJson(json['check'] as Map<String, dynamic>),
  review: json['review'] == null
      ? null
      : ReviewInfo.fromJson(json['review'] as Map<String, dynamic>),
);

Map<String, dynamic> _$StoryToJson(_Story instance) => <String, dynamic>{
  'id': instance.id,
  'headline': instance.headline,
  'topics': instance.topics,
  'what_happened': instance.whatHappened.toJson(),
  'why_it_matters': instance.whyItMatters.toJson(),
  'argument': instance.argument.toJson(),
  'check': instance.check.toJson(),
  'review': instance.review?.toJson(),
};
