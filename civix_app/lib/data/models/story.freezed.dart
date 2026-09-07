// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Story {

 String get id; String get headline; List<String> get topics;@JsonKey(name: 'what_happened') SourcedText get whatHappened;@JsonKey(name: 'why_it_matters') SourcedText get whyItMatters; Argument get argument; Check get check; ReviewInfo? get review;
/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoryCopyWith<Story> get copyWith => _$StoryCopyWithImpl<Story>(this as Story, _$identity);

  /// Serializes this Story to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Story;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Story&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.headline, _this.headline) || other.headline == _this.headline)&&const DeepCollectionEquality().equals(other.topics, _this.topics)&&(identical(other.whatHappened, _this.whatHappened) || other.whatHappened == _this.whatHappened)&&(identical(other.whyItMatters, _this.whyItMatters) || other.whyItMatters == _this.whyItMatters)&&(identical(other.argument, _this.argument) || other.argument == _this.argument)&&(identical(other.check, _this.check) || other.check == _this.check)&&(identical(other.review, _this.review) || other.review == _this.review));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Story;
  return Object.hash(runtimeType,_this.id,_this.headline,const DeepCollectionEquality().hash(_this.topics),_this.whatHappened,_this.whyItMatters,_this.argument,_this.check,_this.review);
}

@override
String toString() {
  final _this = this as Story;
  return 'Story(id: ${_this.id}, headline: ${_this.headline}, topics: ${_this.topics}, whatHappened: ${_this.whatHappened}, whyItMatters: ${_this.whyItMatters}, argument: ${_this.argument}, check: ${_this.check}, review: ${_this.review})';
}


}

/// @nodoc
abstract mixin class $StoryCopyWith<$Res>  {
  factory $StoryCopyWith(Story value, $Res Function(Story) _then) = _$StoryCopyWithImpl;
@useResult
$Res call({
 String id, String headline, List<String> topics,@JsonKey(name: 'what_happened') SourcedText whatHappened,@JsonKey(name: 'why_it_matters') SourcedText whyItMatters, Argument argument, Check check, ReviewInfo? review
});


$SourcedTextCopyWith<$Res> get whatHappened;$SourcedTextCopyWith<$Res> get whyItMatters;$ArgumentCopyWith<$Res> get argument;$CheckCopyWith<$Res> get check;$ReviewInfoCopyWith<$Res>? get review;

}
/// @nodoc
class _$StoryCopyWithImpl<$Res>
    implements $StoryCopyWith<$Res> {
  _$StoryCopyWithImpl(this._self, this._then);

  final Story _self;
  final $Res Function(Story) _then;

/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? headline = null,Object? topics = null,Object? whatHappened = null,Object? whyItMatters = null,Object? argument = null,Object? check = null,Object? review = freezed,}) {
  return _then(Story(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String,topics: null == topics ? _self.topics : topics // ignore: cast_nullable_to_non_nullable
as List<String>,whatHappened: null == whatHappened ? _self.whatHappened : whatHappened // ignore: cast_nullable_to_non_nullable
as SourcedText,whyItMatters: null == whyItMatters ? _self.whyItMatters : whyItMatters // ignore: cast_nullable_to_non_nullable
as SourcedText,argument: null == argument ? _self.argument : argument // ignore: cast_nullable_to_non_nullable
as Argument,check: null == check ? _self.check : check // ignore: cast_nullable_to_non_nullable
as Check,review: freezed == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo?,
  ));
}
/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SourcedTextCopyWith<$Res> get whatHappened {
  
  return $SourcedTextCopyWith<$Res>(_self.whatHappened, (value) {
    return _then(_self.copyWith(whatHappened: value));
  });
}/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SourcedTextCopyWith<$Res> get whyItMatters {
  
  return $SourcedTextCopyWith<$Res>(_self.whyItMatters, (value) {
    return _then(_self.copyWith(whyItMatters: value));
  });
}/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArgumentCopyWith<$Res> get argument {
  
  return $ArgumentCopyWith<$Res>(_self.argument, (value) {
    return _then(_self.copyWith(argument: value));
  });
}/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CheckCopyWith<$Res> get check {
  
  return $CheckCopyWith<$Res>(_self.check, (value) {
    return _then(_self.copyWith(check: value));
  });
}/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res>? get review {
    if (_self.review == null) {
    return null;
  }

  return $ReviewInfoCopyWith<$Res>(_self.review!, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// Adds pattern-matching-related methods to [Story].
extension StoryPatterns on Story {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Story value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Story() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Story value)  $default,){
final _that = this;
switch (_that) {
case _Story():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Story value)?  $default,){
final _that = this;
switch (_that) {
case _Story() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String headline,  List<String> topics, @JsonKey(name: 'what_happened')  SourcedText whatHappened, @JsonKey(name: 'why_it_matters')  SourcedText whyItMatters,  Argument argument,  Check check,  ReviewInfo? review)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Story() when $default != null:
return $default(_that.id,_that.headline,_that.topics,_that.whatHappened,_that.whyItMatters,_that.argument,_that.check,_that.review);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String headline,  List<String> topics, @JsonKey(name: 'what_happened')  SourcedText whatHappened, @JsonKey(name: 'why_it_matters')  SourcedText whyItMatters,  Argument argument,  Check check,  ReviewInfo? review)  $default,) {final _that = this;
switch (_that) {
case _Story():
return $default(_that.id,_that.headline,_that.topics,_that.whatHappened,_that.whyItMatters,_that.argument,_that.check,_that.review);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String headline,  List<String> topics, @JsonKey(name: 'what_happened')  SourcedText whatHappened, @JsonKey(name: 'why_it_matters')  SourcedText whyItMatters,  Argument argument,  Check check,  ReviewInfo? review)?  $default,) {final _that = this;
switch (_that) {
case _Story() when $default != null:
return $default(_that.id,_that.headline,_that.topics,_that.whatHappened,_that.whyItMatters,_that.argument,_that.check,_that.review);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Story implements Story {
  const _Story({required this.id, required this.headline, required  List<String> topics, @JsonKey(name: 'what_happened') required this.whatHappened, @JsonKey(name: 'why_it_matters') required this.whyItMatters, required this.argument, required this.check, this.review}): _topics = topics;
  factory _Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

@override final  String id;
@override final  String headline;
 final  List<String> _topics;
@override List<String> get topics {
  if (_topics is EqualUnmodifiableListView) return _topics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topics);
}

@override@JsonKey(name: 'what_happened') final  SourcedText whatHappened;
@override@JsonKey(name: 'why_it_matters') final  SourcedText whyItMatters;
@override final  Argument argument;
@override final  Check check;
@override final  ReviewInfo? review;

/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoryCopyWith<_Story> get copyWith => __$StoryCopyWithImpl<_Story>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Story&&(identical(other.id, id) || other.id == id)&&(identical(other.headline, headline) || other.headline == headline)&&const DeepCollectionEquality().equals(other.topics, _topics)&&(identical(other.whatHappened, whatHappened) || other.whatHappened == whatHappened)&&(identical(other.whyItMatters, whyItMatters) || other.whyItMatters == whyItMatters)&&(identical(other.argument, argument) || other.argument == argument)&&(identical(other.check, check) || other.check == check)&&(identical(other.review, review) || other.review == review));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,headline,const DeepCollectionEquality().hash(_topics),whatHappened,whyItMatters,argument,check,review);
}

@override
String toString() {
    return 'Story(id: $id, headline: $headline, topics: $topics, whatHappened: $whatHappened, whyItMatters: $whyItMatters, argument: $argument, check: $check, review: $review)';
}


}

/// @nodoc
abstract mixin class _$StoryCopyWith<$Res> implements $StoryCopyWith<$Res> {
  factory _$StoryCopyWith(_Story value, $Res Function(_Story) _then) = __$StoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String headline, List<String> topics,@JsonKey(name: 'what_happened') SourcedText whatHappened,@JsonKey(name: 'why_it_matters') SourcedText whyItMatters, Argument argument, Check check, ReviewInfo? review
});


@override $SourcedTextCopyWith<$Res> get whatHappened;@override $SourcedTextCopyWith<$Res> get whyItMatters;@override $ArgumentCopyWith<$Res> get argument;@override $CheckCopyWith<$Res> get check;@override $ReviewInfoCopyWith<$Res>? get review;

}
/// @nodoc
class __$StoryCopyWithImpl<$Res>
    implements _$StoryCopyWith<$Res> {
  __$StoryCopyWithImpl(this._self, this._then);

  final _Story _self;
  final $Res Function(_Story) _then;

/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? headline = null,Object? topics = null,Object? whatHappened = null,Object? whyItMatters = null,Object? argument = null,Object? check = null,Object? review = freezed,}) {
  return _then(_Story(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String,topics: null == topics ? _self._topics : topics // ignore: cast_nullable_to_non_nullable
as List<String>,whatHappened: null == whatHappened ? _self.whatHappened : whatHappened // ignore: cast_nullable_to_non_nullable
as SourcedText,whyItMatters: null == whyItMatters ? _self.whyItMatters : whyItMatters // ignore: cast_nullable_to_non_nullable
as SourcedText,argument: null == argument ? _self.argument : argument // ignore: cast_nullable_to_non_nullable
as Argument,check: null == check ? _self.check : check // ignore: cast_nullable_to_non_nullable
as Check,review: freezed == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo?,
  ));
}

/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SourcedTextCopyWith<$Res> get whatHappened {
  
  return $SourcedTextCopyWith<$Res>(_self.whatHappened, (value) {
    return _then(_self.copyWith(whatHappened: value));
  });
}/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SourcedTextCopyWith<$Res> get whyItMatters {
  
  return $SourcedTextCopyWith<$Res>(_self.whyItMatters, (value) {
    return _then(_self.copyWith(whyItMatters: value));
  });
}/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ArgumentCopyWith<$Res> get argument {
  
  return $ArgumentCopyWith<$Res>(_self.argument, (value) {
    return _then(_self.copyWith(argument: value));
  });
}/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CheckCopyWith<$Res> get check {
  
  return $CheckCopyWith<$Res>(_self.check, (value) {
    return _then(_self.copyWith(check: value));
  });
}/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res>? get review {
    if (_self.review == null) {
    return null;
  }

  return $ReviewInfoCopyWith<$Res>(_self.review!, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}

// dart format on
