// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_create.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventCreate {

 String get title;@JsonKey(name: 'is_cancelled') bool get isCancelled; String? get description;@JsonKey(name: 'start_at') DateTime? get startAt;@JsonKey(name: 'end_at') DateTime? get endAt;@JsonKey(name: 'actual_start_at') DateTime? get actualStartAt;@JsonKey(name: 'actual_end_at') DateTime? get actualEndAt;
/// Create a copy of EventCreate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventCreateCopyWith<EventCreate> get copyWith => _$EventCreateCopyWithImpl<EventCreate>(this as EventCreate, _$identity);

  /// Serializes this EventCreate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventCreate&&(identical(other.title, title) || other.title == title)&&(identical(other.isCancelled, isCancelled) || other.isCancelled == isCancelled)&&(identical(other.description, description) || other.description == description)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.actualStartAt, actualStartAt) || other.actualStartAt == actualStartAt)&&(identical(other.actualEndAt, actualEndAt) || other.actualEndAt == actualEndAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,isCancelled,description,startAt,endAt,actualStartAt,actualEndAt);

@override
String toString() {
  return 'EventCreate(title: $title, isCancelled: $isCancelled, description: $description, startAt: $startAt, endAt: $endAt, actualStartAt: $actualStartAt, actualEndAt: $actualEndAt)';
}


}

/// @nodoc
abstract mixin class $EventCreateCopyWith<$Res>  {
  factory $EventCreateCopyWith(EventCreate value, $Res Function(EventCreate) _then) = _$EventCreateCopyWithImpl;
@useResult
$Res call({
 String title,@JsonKey(name: 'is_cancelled') bool isCancelled, String? description,@JsonKey(name: 'start_at') DateTime? startAt,@JsonKey(name: 'end_at') DateTime? endAt,@JsonKey(name: 'actual_start_at') DateTime? actualStartAt,@JsonKey(name: 'actual_end_at') DateTime? actualEndAt
});




}
/// @nodoc
class _$EventCreateCopyWithImpl<$Res>
    implements $EventCreateCopyWith<$Res> {
  _$EventCreateCopyWithImpl(this._self, this._then);

  final EventCreate _self;
  final $Res Function(EventCreate) _then;

/// Create a copy of EventCreate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? isCancelled = null,Object? description = freezed,Object? startAt = freezed,Object? endAt = freezed,Object? actualStartAt = freezed,Object? actualEndAt = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,isCancelled: null == isCancelled ? _self.isCancelled : isCancelled // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startAt: freezed == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endAt: freezed == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime?,actualStartAt: freezed == actualStartAt ? _self.actualStartAt : actualStartAt // ignore: cast_nullable_to_non_nullable
as DateTime?,actualEndAt: freezed == actualEndAt ? _self.actualEndAt : actualEndAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [EventCreate].
extension EventCreatePatterns on EventCreate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventCreate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventCreate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventCreate value)  $default,){
final _that = this;
switch (_that) {
case _EventCreate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventCreate value)?  $default,){
final _that = this;
switch (_that) {
case _EventCreate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title, @JsonKey(name: 'is_cancelled')  bool isCancelled,  String? description, @JsonKey(name: 'start_at')  DateTime? startAt, @JsonKey(name: 'end_at')  DateTime? endAt, @JsonKey(name: 'actual_start_at')  DateTime? actualStartAt, @JsonKey(name: 'actual_end_at')  DateTime? actualEndAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventCreate() when $default != null:
return $default(_that.title,_that.isCancelled,_that.description,_that.startAt,_that.endAt,_that.actualStartAt,_that.actualEndAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title, @JsonKey(name: 'is_cancelled')  bool isCancelled,  String? description, @JsonKey(name: 'start_at')  DateTime? startAt, @JsonKey(name: 'end_at')  DateTime? endAt, @JsonKey(name: 'actual_start_at')  DateTime? actualStartAt, @JsonKey(name: 'actual_end_at')  DateTime? actualEndAt)  $default,) {final _that = this;
switch (_that) {
case _EventCreate():
return $default(_that.title,_that.isCancelled,_that.description,_that.startAt,_that.endAt,_that.actualStartAt,_that.actualEndAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title, @JsonKey(name: 'is_cancelled')  bool isCancelled,  String? description, @JsonKey(name: 'start_at')  DateTime? startAt, @JsonKey(name: 'end_at')  DateTime? endAt, @JsonKey(name: 'actual_start_at')  DateTime? actualStartAt, @JsonKey(name: 'actual_end_at')  DateTime? actualEndAt)?  $default,) {final _that = this;
switch (_that) {
case _EventCreate() when $default != null:
return $default(_that.title,_that.isCancelled,_that.description,_that.startAt,_that.endAt,_that.actualStartAt,_that.actualEndAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventCreate implements EventCreate {
  const _EventCreate({required this.title, @JsonKey(name: 'is_cancelled') this.isCancelled = false, this.description, @JsonKey(name: 'start_at') this.startAt, @JsonKey(name: 'end_at') this.endAt, @JsonKey(name: 'actual_start_at') this.actualStartAt, @JsonKey(name: 'actual_end_at') this.actualEndAt});
  factory _EventCreate.fromJson(Map<String, dynamic> json) => _$EventCreateFromJson(json);

@override final  String title;
@override@JsonKey(name: 'is_cancelled') final  bool isCancelled;
@override final  String? description;
@override@JsonKey(name: 'start_at') final  DateTime? startAt;
@override@JsonKey(name: 'end_at') final  DateTime? endAt;
@override@JsonKey(name: 'actual_start_at') final  DateTime? actualStartAt;
@override@JsonKey(name: 'actual_end_at') final  DateTime? actualEndAt;

/// Create a copy of EventCreate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventCreateCopyWith<_EventCreate> get copyWith => __$EventCreateCopyWithImpl<_EventCreate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventCreateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventCreate&&(identical(other.title, title) || other.title == title)&&(identical(other.isCancelled, isCancelled) || other.isCancelled == isCancelled)&&(identical(other.description, description) || other.description == description)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.actualStartAt, actualStartAt) || other.actualStartAt == actualStartAt)&&(identical(other.actualEndAt, actualEndAt) || other.actualEndAt == actualEndAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,isCancelled,description,startAt,endAt,actualStartAt,actualEndAt);

@override
String toString() {
  return 'EventCreate(title: $title, isCancelled: $isCancelled, description: $description, startAt: $startAt, endAt: $endAt, actualStartAt: $actualStartAt, actualEndAt: $actualEndAt)';
}


}

/// @nodoc
abstract mixin class _$EventCreateCopyWith<$Res> implements $EventCreateCopyWith<$Res> {
  factory _$EventCreateCopyWith(_EventCreate value, $Res Function(_EventCreate) _then) = __$EventCreateCopyWithImpl;
@override @useResult
$Res call({
 String title,@JsonKey(name: 'is_cancelled') bool isCancelled, String? description,@JsonKey(name: 'start_at') DateTime? startAt,@JsonKey(name: 'end_at') DateTime? endAt,@JsonKey(name: 'actual_start_at') DateTime? actualStartAt,@JsonKey(name: 'actual_end_at') DateTime? actualEndAt
});




}
/// @nodoc
class __$EventCreateCopyWithImpl<$Res>
    implements _$EventCreateCopyWith<$Res> {
  __$EventCreateCopyWithImpl(this._self, this._then);

  final _EventCreate _self;
  final $Res Function(_EventCreate) _then;

/// Create a copy of EventCreate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? isCancelled = null,Object? description = freezed,Object? startAt = freezed,Object? endAt = freezed,Object? actualStartAt = freezed,Object? actualEndAt = freezed,}) {
  return _then(_EventCreate(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,isCancelled: null == isCancelled ? _self.isCancelled : isCancelled // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startAt: freezed == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endAt: freezed == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime?,actualStartAt: freezed == actualStartAt ? _self.actualStartAt : actualStartAt // ignore: cast_nullable_to_non_nullable
as DateTime?,actualEndAt: freezed == actualEndAt ? _self.actualEndAt : actualEndAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
