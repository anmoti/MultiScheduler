// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_update.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalendarUpdate {

 String? get name;
/// Create a copy of CalendarUpdate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarUpdateCopyWith<CalendarUpdate> get copyWith => _$CalendarUpdateCopyWithImpl<CalendarUpdate>(this as CalendarUpdate, _$identity);

  /// Serializes this CalendarUpdate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarUpdate&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'CalendarUpdate(name: $name)';
}


}

/// @nodoc
abstract mixin class $CalendarUpdateCopyWith<$Res>  {
  factory $CalendarUpdateCopyWith(CalendarUpdate value, $Res Function(CalendarUpdate) _then) = _$CalendarUpdateCopyWithImpl;
@useResult
$Res call({
 String? name
});




}
/// @nodoc
class _$CalendarUpdateCopyWithImpl<$Res>
    implements $CalendarUpdateCopyWith<$Res> {
  _$CalendarUpdateCopyWithImpl(this._self, this._then);

  final CalendarUpdate _self;
  final $Res Function(CalendarUpdate) _then;

/// Create a copy of CalendarUpdate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarUpdate].
extension CalendarUpdatePatterns on CalendarUpdate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarUpdate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarUpdate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarUpdate value)  $default,){
final _that = this;
switch (_that) {
case _CalendarUpdate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarUpdate value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarUpdate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarUpdate() when $default != null:
return $default(_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name)  $default,) {final _that = this;
switch (_that) {
case _CalendarUpdate():
return $default(_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name)?  $default,) {final _that = this;
switch (_that) {
case _CalendarUpdate() when $default != null:
return $default(_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalendarUpdate implements CalendarUpdate {
  const _CalendarUpdate({this.name});
  factory _CalendarUpdate.fromJson(Map<String, dynamic> json) => _$CalendarUpdateFromJson(json);

@override final  String? name;

/// Create a copy of CalendarUpdate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarUpdateCopyWith<_CalendarUpdate> get copyWith => __$CalendarUpdateCopyWithImpl<_CalendarUpdate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalendarUpdateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarUpdate&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'CalendarUpdate(name: $name)';
}


}

/// @nodoc
abstract mixin class _$CalendarUpdateCopyWith<$Res> implements $CalendarUpdateCopyWith<$Res> {
  factory _$CalendarUpdateCopyWith(_CalendarUpdate value, $Res Function(_CalendarUpdate) _then) = __$CalendarUpdateCopyWithImpl;
@override @useResult
$Res call({
 String? name
});




}
/// @nodoc
class __$CalendarUpdateCopyWithImpl<$Res>
    implements _$CalendarUpdateCopyWith<$Res> {
  __$CalendarUpdateCopyWithImpl(this._self, this._then);

  final _CalendarUpdate _self;
  final $Res Function(_CalendarUpdate) _then;

/// Create a copy of CalendarUpdate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,}) {
  return _then(_CalendarUpdate(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
