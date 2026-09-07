// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brief.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Brief {

@JsonKey(name: 'brief_id') String get briefId;@JsonKey(name: 'published_at') DateTime get publishedAt;@JsonKey(name: 'schema_version') int get schemaVersion; List<Story> get stories;
/// Create a copy of Brief
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BriefCopyWith<Brief> get copyWith => _$BriefCopyWithImpl<Brief>(this as Brief, _$identity);

  /// Serializes this Brief to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Brief;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Brief&&(identical(other.briefId, _this.briefId) || other.briefId == _this.briefId)&&(identical(other.publishedAt, _this.publishedAt) || other.publishedAt == _this.publishedAt)&&(identical(other.schemaVersion, _this.schemaVersion) || other.schemaVersion == _this.schemaVersion)&&const DeepCollectionEquality().equals(other.stories, _this.stories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Brief;
  return Object.hash(runtimeType,_this.briefId,_this.publishedAt,_this.schemaVersion,const DeepCollectionEquality().hash(_this.stories));
}

@override
String toString() {
  final _this = this as Brief;
  return 'Brief(briefId: ${_this.briefId}, publishedAt: ${_this.publishedAt}, schemaVersion: ${_this.schemaVersion}, stories: ${_this.stories})';
}


}

/// @nodoc
abstract mixin class $BriefCopyWith<$Res>  {
  factory $BriefCopyWith(Brief value, $Res Function(Brief) _then) = _$BriefCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'brief_id') String briefId,@JsonKey(name: 'published_at') DateTime publishedAt,@JsonKey(name: 'schema_version') int schemaVersion, List<Story> stories
});




}
/// @nodoc
class _$BriefCopyWithImpl<$Res>
    implements $BriefCopyWith<$Res> {
  _$BriefCopyWithImpl(this._self, this._then);

  final Brief _self;
  final $Res Function(Brief) _then;

/// Create a copy of Brief
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? briefId = null,Object? publishedAt = null,Object? schemaVersion = null,Object? stories = null,}) {
  return _then(Brief(
briefId: null == briefId ? _self.briefId : briefId // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,stories: null == stories ? _self.stories : stories // ignore: cast_nullable_to_non_nullable
as List<Story>,
  ));
}

}


/// Adds pattern-matching-related methods to [Brief].
extension BriefPatterns on Brief {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Brief value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Brief() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Brief value)  $default,){
final _that = this;
switch (_that) {
case _Brief():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Brief value)?  $default,){
final _that = this;
switch (_that) {
case _Brief() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'brief_id')  String briefId, @JsonKey(name: 'published_at')  DateTime publishedAt, @JsonKey(name: 'schema_version')  int schemaVersion,  List<Story> stories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Brief() when $default != null:
return $default(_that.briefId,_that.publishedAt,_that.schemaVersion,_that.stories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'brief_id')  String briefId, @JsonKey(name: 'published_at')  DateTime publishedAt, @JsonKey(name: 'schema_version')  int schemaVersion,  List<Story> stories)  $default,) {final _that = this;
switch (_that) {
case _Brief():
return $default(_that.briefId,_that.publishedAt,_that.schemaVersion,_that.stories);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'brief_id')  String briefId, @JsonKey(name: 'published_at')  DateTime publishedAt, @JsonKey(name: 'schema_version')  int schemaVersion,  List<Story> stories)?  $default,) {final _that = this;
switch (_that) {
case _Brief() when $default != null:
return $default(_that.briefId,_that.publishedAt,_that.schemaVersion,_that.stories);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Brief implements Brief {
  const _Brief({@JsonKey(name: 'brief_id') required this.briefId, @JsonKey(name: 'published_at') required this.publishedAt, @JsonKey(name: 'schema_version') required this.schemaVersion, required  List<Story> stories}): _stories = stories;
  factory _Brief.fromJson(Map<String, dynamic> json) => _$BriefFromJson(json);

@override@JsonKey(name: 'brief_id') final  String briefId;
@override@JsonKey(name: 'published_at') final  DateTime publishedAt;
@override@JsonKey(name: 'schema_version') final  int schemaVersion;
 final  List<Story> _stories;
@override List<Story> get stories {
  if (_stories is EqualUnmodifiableListView) return _stories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stories);
}


/// Create a copy of Brief
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BriefCopyWith<_Brief> get copyWith => __$BriefCopyWithImpl<_Brief>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BriefToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Brief&&(identical(other.briefId, briefId) || other.briefId == briefId)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other.stories, _stories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,briefId,publishedAt,schemaVersion,const DeepCollectionEquality().hash(_stories));
}

@override
String toString() {
    return 'Brief(briefId: $briefId, publishedAt: $publishedAt, schemaVersion: $schemaVersion, stories: $stories)';
}


}

/// @nodoc
abstract mixin class _$BriefCopyWith<$Res> implements $BriefCopyWith<$Res> {
  factory _$BriefCopyWith(_Brief value, $Res Function(_Brief) _then) = __$BriefCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'brief_id') String briefId,@JsonKey(name: 'published_at') DateTime publishedAt,@JsonKey(name: 'schema_version') int schemaVersion, List<Story> stories
});




}
/// @nodoc
class __$BriefCopyWithImpl<$Res>
    implements _$BriefCopyWith<$Res> {
  __$BriefCopyWithImpl(this._self, this._then);

  final _Brief _self;
  final $Res Function(_Brief) _then;

/// Create a copy of Brief
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? briefId = null,Object? publishedAt = null,Object? schemaVersion = null,Object? stories = null,}) {
  return _then(_Brief(
briefId: null == briefId ? _self.briefId : briefId // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,stories: null == stories ? _self._stories : stories // ignore: cast_nullable_to_non_nullable
as List<Story>,
  ));
}


}

// dart format on
