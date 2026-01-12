import 'package:multi_scheduler/api/dio_client.dart';
import 'package:multi_scheduler/api/generated/models/calendar_create.dart';
import 'package:multi_scheduler/api/generated/models/calendar_public.dart';
import 'package:multi_scheduler/api/generated/models/event_public.dart';
import 'package:multi_scheduler/api/generated/multi_scheduler_client.dart';

class CalendarRepository {
  final MultiSchedulerClient _client;

  CalendarRepository({MultiSchedulerClient? client})
    : _client = client ?? MultiSchedulerClient(dio);

  Future<List<CalendarPublic>> listCalendars() async {
    return _client.fallback.listCalendarsCalendarsGet();
  }

  Future<List<EventPublic>> listEvents(String calendarId) async {
    return _client.fallback.listEventsCalendarsCalendarIdEventsGet(
      calendarId: calendarId,
    );
  }

  Future<CalendarPublic> createCalendar(String name) async {
    return _client.fallback.createCalendarCalendarsPost(
      body: CalendarCreate(name: name),
    );
  }
}
