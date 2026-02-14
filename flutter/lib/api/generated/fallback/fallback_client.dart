// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/calendar_create.dart';
import '../models/calendar_public.dart';
import '../models/calendar_update.dart';
import '../models/event_create.dart';
import '../models/event_public.dart';
import '../models/event_update.dart';
import '../models/user_create.dart';
import '../models/user_login.dart';
import '../models/user_private.dart';
import '../models/user_session.dart';

part 'fallback_client.g.dart';

@RestApi()
abstract class FallbackClient {
  factory FallbackClient(Dio dio, {String? baseUrl}) = _FallbackClient;

  /// Get User Private.
  ///
  /// ログインしているユーザーの情報を取得.
  @GET('/users/me')
  Future<UserPrivate> getUserPrivateUsersMeGet({
    @DioOptions() RequestOptions? options,
  });

  /// Signup User.
  ///
  /// ユーザーを登録.
  @POST('/auth/signup')
  Future<UserSession> signupUserAuthSignupPost({
    @Body() required UserCreate body,
    @DioOptions() RequestOptions? options,
  });

  /// Signin User.
  ///
  /// ユーザーがサインイン.
  @POST('/auth/signin')
  Future<UserSession> signinUserAuthSigninPost({
    @Body() required UserLogin body,
    @DioOptions() RequestOptions? options,
  });

  /// Refresh Session.
  ///
  /// ユーザーセッションをリフレッシュ.
  @POST('/auth/refresh')
  Future<UserSession> refreshSessionAuthRefreshPost({
    @DioOptions() RequestOptions? options,
  });

  /// Get Calendar.
  ///
  /// カレンダーを取得.
  @GET('/calendars/{calendar_id}/')
  Future<CalendarPublic> getCalendarCalendarsCalendarIdGet({
    @Path('calendar_id') required String calendarId,
    @DioOptions() RequestOptions? options,
  });

  /// Update Calendar.
  ///
  /// カレンダーを更新.
  @PATCH('/calendars/{calendar_id}/')
  Future<CalendarPublic> updateCalendarCalendarsCalendarIdPatch({
    @Path('calendar_id') required String calendarId,
    @Body() required CalendarUpdate body,
    @DioOptions() RequestOptions? options,
  });

  /// Delete Calendar.
  ///
  /// カレンダーを削除.
  @DELETE('/calendars/{calendar_id}/')
  Future<void> deleteCalendarCalendarsCalendarIdDelete({
    @Path('calendar_id') required String calendarId,
    @DioOptions() RequestOptions? options,
  });

  /// List Events.
  ///
  /// イベント一覧を取得.
  @GET('/calendars/{calendar_id}/events')
  Future<List<EventPublic>> listEventsCalendarsCalendarIdEventsGet({
    @Path('calendar_id') required String calendarId,
    @DioOptions() RequestOptions? options,
  });

  /// Create Event.
  ///
  /// イベントを作成.
  @POST('/calendars/{calendar_id}/events')
  Future<EventPublic> createEventCalendarsCalendarIdEventsPost({
    @Path('calendar_id') required String calendarId,
    @Body() required EventCreate body,
    @DioOptions() RequestOptions? options,
  });

  /// Get Event.
  ///
  /// イベントを取得.
  @GET('/calendars/{calendar_id}/events/{event_id}')
  Future<EventPublic> getEventCalendarsCalendarIdEventsEventIdGet({
    @Path('calendar_id') required String calendarId,
    @Path('event_id') required String eventId,
    @DioOptions() RequestOptions? options,
  });

  /// Update Event.
  ///
  /// イベントを更新.
  @PATCH('/calendars/{calendar_id}/events/{event_id}')
  Future<EventPublic> updateEventCalendarsCalendarIdEventsEventIdPatch({
    @Path('calendar_id') required String calendarId,
    @Path('event_id') required String eventId,
    @Body() required EventUpdate body,
    @DioOptions() RequestOptions? options,
  });

  /// List Calendars.
  ///
  /// カレンダー一覧を取得.
  @GET('/calendars/')
  Future<List<CalendarPublic>> listCalendarsCalendarsGet({
    @DioOptions() RequestOptions? options,
  });

  /// Create Calendar.
  ///
  /// カレンダーを作成.
  @POST('/calendars/')
  Future<CalendarPublic> createCalendarCalendarsPost({
    @Body() required CalendarCreate body,
    @DioOptions() RequestOptions? options,
  });

  /// Read Root
  @GET('/')
  Future<Map<String, String>> readRootGet({
    @DioOptions() RequestOptions? options,
  });

  /// Read Item
  @GET('/items/{item_id}')
  Future<Map<String, int>> readItemItemsItemIdGet({
    @Path('item_id') required int itemId,
    @DioOptions() RequestOptions? options,
  });

  /// Trigger Error
  @GET('/error')
  Future<Map<String, num>> triggerErrorErrorGet({
    @DioOptions() RequestOptions? options,
  });
}
