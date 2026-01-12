// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_update.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventUpdate {

 String? get title; String? get description;@JsonKey(name: 'start_at') DateTime? get startAt;@JsonKey(name: 'end_at') DateTime? get endAt;@JsonKey(name: 'actual_start_at') DateTime? get actualStartAt;@JsonKey(name: 'actual_end_at') DateTime? get actualEndAt;@JsonKey(name: 'is_cancelled') bool? get isCancelled;
/// Create a copy of EventUpdate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventUpdateCopyWith<EventUpdate> get copyWith => _$EventUpdateCopyWithImpl<EventUpdate>(this as EventUpdate, _$identity);

  /// Serializes this EventUpdate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventUpdate&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.actualStartAt, actualStartAt) || other.actualStartAt == actualStartAt)&&(identical(other.actualEndAt, actualEndAt) || other.actualEndAt == actualEndAt)&&(identical(other.isCancelled, isCancelled) || other.isCancelled == isCancelled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,startAt,endAt,actualStartAt,actualEndAt,isCancelled);

@override
String toString() {
  return 'EventUpdate(title: $title, description: $description, startAt: $startAt, endAt: $endAt, actualStartAt: $actualStartAt, actualEndAt: $actualEndAt, isCancelled: $isCancelled)';
}


}

/// @nodoc
abstract mixin class $EventUpdateCopyWith<$Res>  {
  factory $EventUpdateCopyWith(EventUpdate value, $Res Function(EventUpdate) _then) = _$EventUpdateCopyWithImpl;
@useResult
$Res call({
 String? title, String? description,@JsonKey(name: 'start_at') DateTime? startAt,@JsonKey(name: 'end_at') DateTime? endAt,@JsonKey(name: 'actual_start_at') DateTime? actualStartAt,@JsonKey(name: 'actual_end_at') DateTime? actualEndAt,@JsonKey(name: 'is_cancelled') bool? isCancelled
});




}
/// @nodoc
class _$EventUpdateCopyWithImpl<$Res>
    implements $EventUpdateCopyWith<$Res> {
  _$EventUpdateCopyWithImpl(this._self, this._then);

  final EventUpdate _self;
  final $Res Function(EventUpdate) _then;

/// Create a copy of EventUpdate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? description = freezed,Object? startAt = freezed,Object? endAt = freezed,Object? actualStartAt = freezed,Object? actualEndAt = freezed,Object? isCancelled = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startAt: freezed == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endAt: freezed == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime?,actualStartAt: freezed == actualStartAt ? _self.actualStartAt : actualStartAt // ignore: cast_nullable_to_non_nullable
as DateTime?,actualEndAt: freezed == actualEndAt ? _self.actualEndAt : actualEndAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isCancelled: freezed == isCancelled ? _self.isCancelled : isCancelled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [EventUpdate].
extension EventUpdatePatterns on EventUpdate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventUpdate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventUpdate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventUpdate value)  $default,){
final _that = this;
switch (_that) {
case _EventUpdate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventUpdate value)?  $default,){
final _that = this;
switch (_that) {
case _EventUpdate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? title,  String? description, @JsonKey(name: 'start_at')  DateTime? startAt, @JsonKey(name: 'end_at')  DateTime? endAt, @JsonKey(name: 'actual_start_at')  DateTime? actualStartAt, @JsonKey(name: 'actual_end_at')  DateTime? actualEndAt, @JsonKey(name: 'is_cancelled')  bool? isCancelled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventUpdate() when $default != null:
return $default(_that.title,_that.description,_that.startAt,_that.endAt,_that.actualStartAt,_that.actualEndAt,_that.isCancelled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? title,  String? description, @JsonKey(name: 'start_at')  DateTime? startAt, @JsonKey(name: 'end_at')  DateTime? endAt, @JsonKey(name: 'actual_start_at')  DateTime? actualStartAt, @JsonKey(name: 'actual_end_at')  DateTime? actualEndAt, @JsonKey(name: 'is_cancelled')  bool? isCancelled)  $default,) {final _that = this;
switch (_that) {
case _EventUpdate():
return $default(_that.title,_that.description,_that.startAt,_that.endAt,_that.actualStartAt,_that.actualEndAt,_that.isCancelled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? title,  String? description, @JsonKey(name: 'start_at')  DateTime? startAt, @JsonKey(name: 'end_at')  DateTime? endAt, @JsonKey(name: 'actual_start_at')  DateTime? actualStartAt, @JsonKey(name: 'actual_end_at')  DateTime? actualEndAt, @JsonKey(name: 'is_cancelled')  bool? isCancelled)?  $default,) {final _that = this;
switch (_that) {
case _EventUpdate() when $default != null:
return $default(_that.title,_that.description,_that.startAt,_that.endAt,_that.actualStartAt,_that.actualEndAt,_that.isCancelled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventUpdate implements EventUpdate {
  const _EventUpdate({this.title, this.description, @JsonKey(name: 'start_at') this.startAt, @JsonKey(name: 'end_at') this.endAt, @JsonKey(name: 'actual_start_at') this.actualStartAt, @JsonKey(name: 'actual_end_at') this.actualEndAt, @JsonKey(name: 'is_cancelled') this.isCancelled});
  factory _EventUpdate.fromJson(Map<String, dynamic> json) => _$EventUpdateFromJson(json);

@override final  String? title;
@override final  String? description;
@override@JsonKey(name: 'start_at') final  DateTime? startAt;
@override@JsonKey(name: 'end_at') final  DateTime? endAt;
@override@JsonKey(name: 'actual_start_at') final  DateTime? actualStartAt;
@override@JsonKey(name: 'actual_end_at') final  DateTime? actualEndAt;
@override@JsonKey(name: 'is_cancelled') final  bool? isCancelled;

/// Create a copy of EventUpdate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventUpdateCopyWith<_EventUpdate> get copyWith => __$EventUpdateCopyWithImpl<_EventUpdate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventUpdateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventUpdate&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.actualStartAt, actualStartAt) || other.actualStartAt == actualStartAt)&&(identical(other.actualEndAt, actualEndAt) || other.actualEndAt == actualEndAt)&&(identical(other.isCancelled, isCancelled) || other.isCancelled == isCancelled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,startAt,endAt,actualStartAt,actualEndAt,isCancelled);

@override
String toString() {
  return 'EventUpdate(title: $title, description: $description, startAt: $startAt, endAt: $endAt, actualStartAt: $actualStartAt, actualEndAt: $actualEndAt, isCancelled: $isCancelled)';
}


}

/// @nodoc
abstract mixin class _$EventUpdateCopyWith<$Res> implements $EventUpdateCopyWith<$Res> {
  factory _$EventUpdateCopyWith(_EventUpdate value, $Res Function(_EventUpdate) _then) = __$EventUpdateCopyWithImpl;
@override @useResult
$Res call({
 String? title, String? description,@JsonKey(name: 'start_at') DateTime? startAt,@JsonKey(name: 'end_at') DateTime? endAt,@JsonKey(name: 'actual_start_at') DateTime? actualStartAt,@JsonKey(name: 'actual_end_at') DateTime? actualEndAt,@JsonKey(name: 'is_cancelled') bool? isCancelled
});




}
/// @nodoc
class __$EventUpdateCopyWithImpl<$Res>
    implements _$EventUpdateCopyWith<$Res> {
  __$EventUpdateCopyWithImpl(this._self, this._then);

  final _EventUpdate _self;
  final $Res Function(_EventUpdate) _then;

/// Create a copy of EventUpdate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? description = freezed,Object? startAt = freezed,Object? endAt = freezed,Object? actualStartAt = freezed,Object? actualEndAt = freezed,Object? isCancelled = freezed,}) {
  return _then(_EventUpdate(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startAt: freezed == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endAt: freezed == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime?,actualStartAt: freezed == actualStartAt ? _self.actualStartAt : actualStartAt // ignore: cast_nullable_to_non_nullable
as DateTime?,actualEndAt: freezed == actualEndAt ? _self.actualEndAt : actualEndAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isCancelled: freezed == isCancelled ? _self.isCancelled : isCancelled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
