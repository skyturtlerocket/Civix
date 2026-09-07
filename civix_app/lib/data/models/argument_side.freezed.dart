// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'argument_side.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ArgumentSide {

 String get label; String get text;@JsonKey(name: 'word_count') int get wordCount;
/// Create a copy of ArgumentSide
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArgumentSideCopyWith<ArgumentSide> get copyWith => _$ArgumentSideCopyWithImpl<ArgumentSide>(this as ArgumentSide, _$identity);

  /// Serializes this ArgumentSide to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ArgumentSide;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArgumentSide&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.wordCount, _this.wordCount) || other.wordCount == _this.wordCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ArgumentSide;
  return Object.hash(runtimeType,_this.label,_this.text,_this.wordCount);
}

@override
String toString() {
  final _this = this as ArgumentSide;
  return 'ArgumentSide(label: ${_this.label}, text: ${_this.text}, wordCount: ${_this.wordCount})';
}


}

/// @nodoc
abstract mixin class $ArgumentSideCopyWith<$Res>  {
  factory $ArgumentSideCopyWith(ArgumentSide value, $Res Function(ArgumentSide) _then) = _$ArgumentSideCopyWithImpl;
@useResult
$Res call({
 String label, String text,@JsonKey(name: 'word_count') int wordCount
});




}
/// @nodoc
class _$ArgumentSideCopyWithImpl<$Res>
    implements $ArgumentSideCopyWith<$Res> {
  _$ArgumentSideCopyWithImpl(this._self, this._then);

  final ArgumentSide _self;
  final $Res Function(ArgumentSide) _then;

/// Create a copy of ArgumentSide
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? text = null,Object? wordCount = null,}) {
  return _then(ArgumentSide(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,wordCount: null == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ArgumentSide].
extension ArgumentSidePatterns on ArgumentSide {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArgumentSide value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArgumentSide() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArgumentSide value)  $default,){
final _that = this;
switch (_that) {
case _ArgumentSide():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArgumentSide value)?  $default,){
final _that = this;
switch (_that) {
case _ArgumentSide() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  String text, @JsonKey(name: 'word_count')  int wordCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArgumentSide() when $default != null:
return $default(_that.label,_that.text,_that.wordCount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  String text, @JsonKey(name: 'word_count')  int wordCount)  $default,) {final _that = this;
switch (_that) {
case _ArgumentSide():
return $default(_that.label,_that.text,_that.wordCount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  String text, @JsonKey(name: 'word_count')  int wordCount)?  $default,) {final _that = this;
switch (_that) {
case _ArgumentSide() when $default != null:
return $default(_that.label,_that.text,_that.wordCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArgumentSide implements ArgumentSide {
  const _ArgumentSide({required this.label, required this.text, @JsonKey(name: 'word_count') required this.wordCount});
  factory _ArgumentSide.fromJson(Map<String, dynamic> json) => _$ArgumentSideFromJson(json);

@override final  String label;
@override final  String text;
@override@JsonKey(name: 'word_count') final  int wordCount;

/// Create a copy of ArgumentSide
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArgumentSideCopyWith<_ArgumentSide> get copyWith => __$ArgumentSideCopyWithImpl<_ArgumentSide>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArgumentSideToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArgumentSide&&(identical(other.label, label) || other.label == label)&&(identical(other.text, text) || other.text == text)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,label,text,wordCount);
}

@override
String toString() {
    return 'ArgumentSide(label: $label, text: $text, wordCount: $wordCount)';
}


}

/// @nodoc
abstract mixin class _$ArgumentSideCopyWith<$Res> implements $ArgumentSideCopyWith<$Res> {
  factory _$ArgumentSideCopyWith(_ArgumentSide value, $Res Function(_ArgumentSide) _then) = __$ArgumentSideCopyWithImpl;
@override @useResult
$Res call({
 String label, String text,@JsonKey(name: 'word_count') int wordCount
});




}
/// @nodoc
class __$ArgumentSideCopyWithImpl<$Res>
    implements _$ArgumentSideCopyWith<$Res> {
  __$ArgumentSideCopyWithImpl(this._self, this._then);

  final _ArgumentSide _self;
  final $Res Function(_ArgumentSide) _then;

/// Create a copy of ArgumentSide
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? text = null,Object? wordCount = null,}) {
  return _then(_ArgumentSide(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,wordCount: null == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
