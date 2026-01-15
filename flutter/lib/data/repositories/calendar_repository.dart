import 'package:multi_scheduler/api/generated/models/calendar_create.dart';
import 'package:multi_scheduler/api/generated/models/calendar_public.dart';
import 'package:multi_scheduler/api/generated/models/event_public.dart';
import 'package:multi_scheduler/api/generated/multi_scheduler_client.dart';

class CalendarRepository {
  CalendarRepository(this.client);

  final MultiSchedulerClient client;

  Future<List<CalendarPublic>> listCalendars() async {
    return client.fallback.listCalendarsCalendarsGet();
  }

  Future<List<EventPublic>> listEvents(String calendarId) async {
    return client.fallback.listEventsCalendarsCalendarIdEventsGet(
      calendarId: calendarId,
    );
  }

  Future<CalendarPublic> createCalendar(String name) async {
    return client.fallback.createCalendarCalendarsPost(
      body: CalendarCreate(name: name),
    );
  }
}
