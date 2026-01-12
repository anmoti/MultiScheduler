// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_private.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserPrivate {

 String get name; String get id; String get nickname;
/// Create a copy of UserPrivate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserPrivateCopyWith<UserPrivate> get copyWith => _$UserPrivateCopyWithImpl<UserPrivate>(this as UserPrivate, _$identity);

  /// Serializes this UserPrivate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserPrivate&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id)&&(identical(other.nickname, nickname) || other.nickname == nickname));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,id,nickname);

@override
String toString() {
  return 'UserPrivate(name: $name, id: $id, nickname: $nickname)';
}


}

/// @nodoc
abstract mixin class $UserPrivateCopyWith<$Res>  {
  factory $UserPrivateCopyWith(UserPrivate value, $Res Function(UserPrivate) _then) = _$UserPrivateCopyWithImpl;
@useResult
$Res call({
 String name, String id, String nickname
});




}
/// @nodoc
class _$UserPrivateCopyWithImpl<$Res>
    implements $UserPrivateCopyWith<$Res> {
  _$UserPrivateCopyWithImpl(this._self, this._then);

  final UserPrivate _self;
  final $Res Function(UserPrivate) _then;

/// Create a copy of UserPrivate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? id = null,Object? nickname = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserPrivate].
extension UserPrivatePatterns on UserPrivate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserPrivate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserPrivate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserPrivate value)  $default,){
final _that = this;
switch (_that) {
case _UserPrivate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserPrivate value)?  $default,){
final _that = this;
switch (_that) {
case _UserPrivate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String id,  String nickname)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserPrivate() when $default != null:
return $default(_that.name,_that.id,_that.nickname);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String id,  String nickname)  $default,) {final _that = this;
switch (_that) {
case _UserPrivate():
return $default(_that.name,_that.id,_that.nickname);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String id,  String nickname)?  $default,) {final _that = this;
switch (_that) {
case _UserPrivate() when $default != null:
return $default(_that.name,_that.id,_that.nickname);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserPrivate implements UserPrivate {
  const _UserPrivate({required this.name, required this.id, required this.nickname});
  factory _UserPrivate.fromJson(Map<String, dynamic> json) => _$UserPrivateFromJson(json);

@override final  String name;
@override final  String id;
@override final  String nickname;

/// Create a copy of UserPrivate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserPrivateCopyWith<_UserPrivate> get copyWith => __$UserPrivateCopyWithImpl<_UserPrivate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserPrivateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserPrivate&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id)&&(identical(other.nickname, nickname) || other.nickname == nickname));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,id,nickname);

@override
String toString() {
  return 'UserPrivate(name: $name, id: $id, nickname: $nickname)';
}


}

/// @nodoc
abstract mixin class _$UserPrivateCopyWith<$Res> implements $UserPrivateCopyWith<$Res> {
  factory _$UserPrivateCopyWith(_UserPrivate value, $Res Function(_UserPrivate) _then) = __$UserPrivateCopyWithImpl;
@override @useResult
$Res call({
 String name, String id, String nickname
});




}
/// @nodoc
class __$UserPrivateCopyWithImpl<$Res>
    implements _$UserPrivateCopyWith<$Res> {
  __$UserPrivateCopyWithImpl(this._self, this._then);

  final _UserPrivate _self;
  final $Res Function(_UserPrivate) _then;

/// Create a copy of UserPrivate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? id = null,Object? nickname = null,}) {
  return _then(_UserPrivate(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
