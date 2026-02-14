import 'package:flutter/foundation.dart';
import 'package:multi_scheduler/api/generated/models/calendar_create.dart';
import 'package:multi_scheduler/api/generated/models/calendar_public.dart';
import 'package:multi_scheduler/api/generated/models/event_public.dart';
import 'package:multi_scheduler/api/generated/multi_scheduler_client.dart';

class CalendarRepository {
  CalendarRepository(this.client);

  final MultiSchedulerClient client;

  static const _cacheDuration = Duration(seconds: 30);

  List<CalendarPublic>? _cachedCalendars;
  DateTime? _lastFetchTime;

  bool get _isCacheValid =>
      _cachedCalendars != null &&
      _lastFetchTime != null &&
      DateTime.now().difference(_lastFetchTime!) < _cacheDuration;

  Future<List<CalendarPublic>> listCalendars() async {
    if (_isCacheValid) {
      return _cachedCalendars!;
    }

    // キャッシュがあるが期限切れの場合: キャッシュを返しつつバックグラウンドで更新
    if (_cachedCalendars != null) {
      _refreshInBackground();
      return _cachedCalendars!;
    }

    // キャッシュがない場合: 取得して返す
    return _fetchAndCache();
  }

  Future<List<CalendarPublic>> _fetchAndCache() async {
    final calendars = await client.fallback.listCalendarsCalendarsGet();
    _cachedCalendars = calendars;
    _lastFetchTime = DateTime.now();
    return calendars;
  }

  void _refreshInBackground() async {
    try {
      final oldCalendars = _cachedCalendars;
      final newCalendars = await _fetchAndCache();

      final isChanged = !listEquals(
        oldCalendars?.map((c) => c.id).toList(),
        newCalendars.map((c) => c.id).toList(),
      );

      if (isChanged) {
        calendarNotifier.notify();
      }
    } catch (_) {
      // バックグラウンド更新の失敗は無視
    }
  }

  void _invalidateCache() {
    _cachedCalendars = null;
    _lastFetchTime = null;
  }

  Future<List<EventPublic>> listEvents(String calendarId) async {
    return client.fallback.listEventsCalendarsCalendarIdEventsGet(
      calendarId: calendarId,
    );
  }

  Future<CalendarPublic> createCalendar(String name) async {
    final calendar = await client.fallback.createCalendarCalendarsPost(
      body: CalendarCreate(name: name),
    );
    _invalidateCache();
    calendarNotifier.notify();

    return calendar;
  }

  Future<void> deleteCalendar(String calendarId) async {
    await client.fallback.deleteCalendarCalendarsCalendarIdDelete(
      calendarId: calendarId,
    );
    _invalidateCache();
    calendarNotifier.notify();
  }
}

class CalendarNotifier extends ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}

final calendarNotifier = CalendarNotifier();
