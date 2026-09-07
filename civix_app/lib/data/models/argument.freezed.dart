// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'argument.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Argument {

@JsonKey(name: 'side_a') ArgumentSide get sideA;@JsonKey(name: 'side_b') ArgumentSide get sideB;
/// Create a copy of Argument
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArgumentCopyWith<Argument> get copyWith => _$ArgumentCopyWithImpl<Argument>(this as Argument, _$identity);

  /// Serializes this Argument to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Argument;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Argument&&(identical(other.sideA, _this.sideA) || other.sideA == _this.sideA)&&(identical(other.sideB, _this.sideB) || other.sideB == _this.sideB));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Argument;
  return Object.hash(runtimeType,_this.sideA,_this.sideB);
}

@override
String toString() {
  final _this = this as Argument;
  return 'Argument(sideA: ${_this.sideA}, sideB: ${_this.sideB})';
}


}

/// @nodoc
abstract mixin class $ArgumentCopyWith<$Res>  {
  factory $ArgumentCopyWith(Argument value, $Res Function(Argument) _then) = _$ArgumentCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'side_a') ArgumentSide sideA,@JsonKey(name: 'side_b') ArgumentSide sideB
});


$ArgumentSideCopyWith<$Res> get sideA;$ArgumentSideCopyWith<$Res> get sideB;

}
/// @nodoc
class _$ArgumentCopyWithImpl<$Res>
    implements $ArgumentCopyWith<$Res> {
  _$ArgumentCopyWithImpl(this._self, this._then);

  final Argument _self;
  final $Res Function(Argument) _then;

/// Create a copy of Argument
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sideA = null,Object? sideB = null,}) {
  return _then(Argument(
sideA: null == sideA ? _self.sideA : sideA // ignore: cast_nullable_to_non_nullable
as ArgumentSide,sideB: null == sideB ? _self.sideB : sideB // ignore: cast_nullable_to_non_nullable
as ArgumentSide,
  ));
}
/// Create a copy of Argument
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArgumentSideCopyWith<$Res> get sideA {
  
  return $ArgumentSideCopyWith<$Res>(_self.sideA, (value) {
    return _then(_self.copyWith(sideA: value));
  });
}/// Create a copy of Argument
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArgumentSideCopyWith<$Res> get sideB {
  
  return $ArgumentSideCopyWith<$Res>(_self.sideB, (value) {
    return _then(_self.copyWith(sideB: value));
  });
}
}


/// Adds pattern-matching-related methods to [Argument].
extension ArgumentPatterns on Argument {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Argument value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Argument() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Argument value)  $default,){
final _that = this;
switch (_that) {
case _Argument():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Argument value)?  $default,){
final _that = this;
switch (_that) {
case _Argument() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'side_a')  ArgumentSide sideA, @JsonKey(name: 'side_b')  ArgumentSide sideB)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Argument() when $default != null:
return $default(_that.sideA,_that.sideB);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'side_a')  ArgumentSide sideA, @JsonKey(name: 'side_b')  ArgumentSide sideB)  $default,) {final _that = this;
switch (_that) {
case _Argument():
return $default(_that.sideA,_that.sideB);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'side_a')  ArgumentSide sideA, @JsonKey(name: 'side_b')  ArgumentSide sideB)?  $default,) {final _that = this;
switch (_that) {
case _Argument() when $default != null:
return $default(_that.sideA,_that.sideB);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Argument implements Argument {
  const _Argument({@JsonKey(name: 'side_a') required this.sideA, @JsonKey(name: 'side_b') required this.sideB});
  factory _Argument.fromJson(Map<String, dynamic> json) => _$ArgumentFromJson(json);

@override@JsonKey(name: 'side_a') final  ArgumentSide sideA;
@override@JsonKey(name: 'side_b') final  ArgumentSide sideB;

/// Create a copy of Argument
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArgumentCopyWith<_Argument> get copyWith => __$ArgumentCopyWithImpl<_Argument>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArgumentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Argument&&(identical(other.sideA, sideA) || other.sideA == sideA)&&(identical(other.sideB, sideB) || other.sideB == sideB));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sideA,sideB);
}

@override
String toString() {
    return 'Argument(sideA: $sideA, sideB: $sideB)';
}


}

/// @nodoc
abstract mixin class _$ArgumentCopyWith<$Res> implements $ArgumentCopyWith<$Res> {
  factory _$ArgumentCopyWith(_Argument value, $Res Function(_Argument) _then) = __$ArgumentCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'side_a') ArgumentSide sideA,@JsonKey(name: 'side_b') ArgumentSide sideB
});


@override $ArgumentSideCopyWith<$Res> get sideA;@override $ArgumentSideCopyWith<$Res> get sideB;

}
/// @nodoc
class __$ArgumentCopyWithImpl<$Res>
    implements _$ArgumentCopyWith<$Res> {
  __$ArgumentCopyWithImpl(this._self, this._then);

  final _Argument _self;
  final $Res Function(_Argument) _then;

/// Create a copy of Argument
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sideA = null,Object? sideB = null,}) {
  return _then(_Argument(
sideA: null == sideA ? _self.sideA : sideA // ignore: cast_nullable_to_non_nullable
as ArgumentSide,sideB: null == sideB ? _self.sideB : sideB // ignore: cast_nullable_to_non_nullable
as ArgumentSide,
  ));
}

/// Create a copy of Argument
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArgumentSideCopyWith<$Res> get sideA {
  
  return $ArgumentSideCopyWith<$Res>(_self.sideA, (value) {
    return _then(_self.copyWith(sideA: value));
  });
}/// Create a copy of Argument
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArgumentSideCopyWith<$Res> get sideB {
  
  return $ArgumentSideCopyWith<$Res>(_self.sideB, (value) {
    return _then(_self.copyWith(sideB: value));
  });
}
}

// dart format on
