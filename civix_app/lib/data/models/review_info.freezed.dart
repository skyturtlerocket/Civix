// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReviewInfo {

@JsonKey(name: 'approved_at') DateTime get approvedAt; bool get edited;
/// Create a copy of ReviewInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<ReviewInfo> get copyWith => _$ReviewInfoCopyWithImpl<ReviewInfo>(this as ReviewInfo, _$identity);

  /// Serializes this ReviewInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReviewInfo;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewInfo&&(identical(other.approvedAt, _this.approvedAt) || other.approvedAt == _this.approvedAt)&&(identical(other.edited, _this.edited) || other.edited == _this.edited));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReviewInfo;
  return Object.hash(runtimeType,_this.approvedAt,_this.edited);
}

@override
String toString() {
  final _this = this as ReviewInfo;
  return 'ReviewInfo(approvedAt: ${_this.approvedAt}, edited: ${_this.edited})';
}


}

/// @nodoc
abstract mixin class $ReviewInfoCopyWith<$Res>  {
  factory $ReviewInfoCopyWith(ReviewInfo value, $Res Function(ReviewInfo) _then) = _$ReviewInfoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'approved_at') DateTime approvedAt, bool edited
});




}
/// @nodoc
class _$ReviewInfoCopyWithImpl<$Res>
    implements $ReviewInfoCopyWith<$Res> {
  _$ReviewInfoCopyWithImpl(this._self, this._then);

  final ReviewInfo _self;
  final $Res Function(ReviewInfo) _then;

/// Create a copy of ReviewInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? approvedAt = null,Object? edited = null,}) {
  return _then(ReviewInfo(
approvedAt: null == approvedAt ? _self.approvedAt : approvedAt // ignore: cast_nullable_to_non_nullable
as DateTime,edited: null == edited ? _self.edited : edited // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ReviewInfo].
extension ReviewInfoPatterns on ReviewInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReviewInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReviewInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReviewInfo value)  $default,){
final _that = this;
switch (_that) {
case _ReviewInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReviewInfo value)?  $default,){
final _that = this;
switch (_that) {
case _ReviewInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'approved_at')  DateTime approvedAt,  bool edited)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewInfo() when $default != null:
return $default(_that.approvedAt,_that.edited);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'approved_at')  DateTime approvedAt,  bool edited)  $default,) {final _that = this;
switch (_that) {
case _ReviewInfo():
return $default(_that.approvedAt,_that.edited);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'approved_at')  DateTime approvedAt,  bool edited)?  $default,) {final _that = this;
switch (_that) {
case _ReviewInfo() when $default != null:
return $default(_that.approvedAt,_that.edited);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReviewInfo implements ReviewInfo {
  const _ReviewInfo({@JsonKey(name: 'approved_at') required this.approvedAt, required this.edited});
  factory _ReviewInfo.fromJson(Map<String, dynamic> json) => _$ReviewInfoFromJson(json);

@override@JsonKey(name: 'approved_at') final  DateTime approvedAt;
@override final  bool edited;

/// Create a copy of ReviewInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewInfoCopyWith<_ReviewInfo> get copyWith => __$ReviewInfoCopyWithImpl<_ReviewInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReviewInfoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewInfo&&(identical(other.approvedAt, approvedAt) || other.approvedAt == approvedAt)&&(identical(other.edited, edited) || other.edited == edited));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,approvedAt,edited);
}

@override
String toString() {
    return 'ReviewInfo(approvedAt: $approvedAt, edited: $edited)';
}


}

/// @nodoc
abstract mixin class _$ReviewInfoCopyWith<$Res> implements $ReviewInfoCopyWith<$Res> {
  factory _$ReviewInfoCopyWith(_ReviewInfo value, $Res Function(_ReviewInfo) _then) = __$ReviewInfoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'approved_at') DateTime approvedAt, bool edited
});




}
/// @nodoc
class __$ReviewInfoCopyWithImpl<$Res>
    implements _$ReviewInfoCopyWith<$Res> {
  __$ReviewInfoCopyWithImpl(this._self, this._then);

  final _ReviewInfo _self;
  final $Res Function(_ReviewInfo) _then;

/// Create a copy of ReviewInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? approvedAt = null,Object? edited = null,}) {
  return _then(_ReviewInfo(
approvedAt: null == approvedAt ? _self.approvedAt : approvedAt // ignore: cast_nullable_to_non_nullable
as DateTime,edited: null == edited ? _self.edited : edited // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
