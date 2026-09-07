// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'argument.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Argument _$ArgumentFromJson(Map<String, dynamic> json) => _Argument(
  sideA: ArgumentSide.fromJson(json['side_a'] as Map<String, dynamic>),
  sideB: ArgumentSide.fromJson(json['side_b'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ArgumentToJson(_Argument instance) => <String, dynamic>{
  'side_a': instance.sideA.toJson(),
  'side_b': instance.sideB.toJson(),
};
