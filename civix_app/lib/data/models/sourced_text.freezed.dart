// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sourced_text.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SourcedText {

 String get text; List<Citation> get citations;
/// Create a copy of SourcedText
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SourcedTextCopyWith<SourcedText> get copyWith => _$SourcedTextCopyWithImpl<SourcedText>(this as SourcedText, _$identity);

  /// Serializes this SourcedText to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SourcedText;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SourcedText&&(identical(other.text, _this.text) || other.text == _this.text)&&const DeepCollectionEquality().equals(other.citations, _this.citations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SourcedText;
  return Object.hash(runtimeType,_this.text,const DeepCollectionEquality().hash(_this.citations));
}

@override
String toString() {
  final _this = this as SourcedText;
  return 'SourcedText(text: ${_this.text}, citations: ${_this.citations})';
}


}

/// @nodoc
abstract mixin class $SourcedTextCopyWith<$Res>  {
  factory $SourcedTextCopyWith(SourcedText value, $Res Function(SourcedText) _then) = _$SourcedTextCopyWithImpl;
@useResult
$Res call({
 String text, List<Citation> citations
});




}
/// @nodoc
class _$SourcedTextCopyWithImpl<$Res>
    implements $SourcedTextCopyWith<$Res> {
  _$SourcedTextCopyWithImpl(this._self, this._then);

  final SourcedText _self;
  final $Res Function(SourcedText) _then;

/// Create a copy of SourcedText
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? citations = null,}) {
  return _then(SourcedText(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,
  ));
}

}


/// Adds pattern-matching-related methods to [SourcedText].
extension SourcedTextPatterns on SourcedText {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SourcedText value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SourcedText() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SourcedText value)  $default,){
final _that = this;
switch (_that) {
case _SourcedText():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SourcedText value)?  $default,){
final _that = this;
switch (_that) {
case _SourcedText() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  List<Citation> citations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SourcedText() when $default != null:
return $default(_that.text,_that.citations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  List<Citation> citations)  $default,) {final _that = this;
switch (_that) {
case _SourcedText():
return $default(_that.text,_that.citations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  List<Citation> citations)?  $default,) {final _that = this;
switch (_that) {
case _SourcedText() when $default != null:
return $default(_that.text,_that.citations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SourcedText implements SourcedText {
  const _SourcedText({required this.text, required  List<Citation> citations}): _citations = citations;
  factory _SourcedText.fromJson(Map<String, dynamic> json) => _$SourcedTextFromJson(json);

@override final  String text;
 final  List<Citation> _citations;
@override List<Citation> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}


/// Create a copy of SourcedText
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SourcedTextCopyWith<_SourcedText> get copyWith => __$SourcedTextCopyWithImpl<_SourcedText>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SourcedTextToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SourcedText&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other.citations, _citations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,text,const DeepCollectionEquality().hash(_citations));
}

@override
String toString() {
    return 'SourcedText(text: $text, citations: $citations)';
}


}

/// @nodoc
abstract mixin class _$SourcedTextCopyWith<$Res> implements $SourcedTextCopyWith<$Res> {
  factory _$SourcedTextCopyWith(_SourcedText value, $Res Function(_SourcedText) _then) = __$SourcedTextCopyWithImpl;
@override @useResult
$Res call({
 String text, List<Citation> citations
});




}
/// @nodoc
class __$SourcedTextCopyWithImpl<$Res>
    implements _$SourcedTextCopyWith<$Res> {
  __$SourcedTextCopyWithImpl(this._self, this._then);

  final _SourcedText _self;
  final $Res Function(_SourcedText) _then;

/// Create a copy of SourcedText
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? citations = null,}) {
  return _then(_SourcedText(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,
  ));
}


}

// dart format on
