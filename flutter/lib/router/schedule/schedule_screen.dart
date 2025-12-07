import 'package:flutter/material.dart';
import 'package:multi_scheduler/helper/time.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: CalendarWidget());
  }
}

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  static const WeekDay _firstDayOfWeek = WeekDay.sunday;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarHeader(firstDayOfWeek: _firstDayOfWeek),
        MonthView(
          firstDayOfWeek: _firstDayOfWeek,
          startDate: DateTime(2025, 11, 1),
          endDate: DateTime(2025, 12, 31),
        ),
      ],
    );
  }
}

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({required this.firstDayOfWeek, super.key});

  final WeekDay firstDayOfWeek;

  @override
  Widget build(BuildContext context) {
    WeekDay weekDay = firstDayOfWeek;

    return Container(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (
              int i = 0;
              i == 0 || weekDay != firstDayOfWeek;
              i++, weekDay = weekDay.next()
            ) ...[
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Text(
                      weekDay.ja,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _getDayColor(weekDay),
                      ),
                    ),
                  ),
                ),
              ),

              if (weekDay != firstDayOfWeek.previous())
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
            ],
          ],
        ),
      ),
    );
  }

  Color? _getDayColor(WeekDay label) {
    switch (label) {
      case WeekDay.sunday:
        return Colors.red;
      case WeekDay.saturday:
        return Colors.blue;
      default:
        return null; // テーマのデフォルト色を使用
    }
  }
}

class MonthView extends StatelessWidget {
  MonthView({
    required this.firstDayOfWeek,
    required this.startDate,
    required this.endDate,
    super.key,
  });

  final WeekDay firstDayOfWeek;
  final DateTime startDate;
  final DateTime endDate;

  final List<Event> events = [
    Event(
      '会議',
      DateTime(2025, 11, 30, 10, 0),
      DateTime(2025, 11, 30, 12, 0),
      Colors.blue,
    ),
    Event(
      '旅行',
      DateTime(2025, 12, 1, 9, 0),
      DateTime(2025, 12, 3, 10, 0),
      Colors.purple,
    ),
    Event(
      'ランチ',
      DateTime(2025, 12, 1, 12, 0),
      DateTime(2025, 12, 1, 13, 0),
      Colors.green,
    ),
    Event(
      'ミーティング',
      DateTime(2025, 12, 2, 14, 0),
      DateTime(2025, 12, 2, 15, 30),
      Colors.orange,
    ),
    Event(
      'ランチ',
      DateTime(2025, 12, 2, 12, 0),
      DateTime(2025, 12, 2, 13, 0),
      Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final int offset = (startDate.weekday - firstDayOfWeek.id) % 7;
    final DateTime firstVisibleDate = startDate.subtract(
      Duration(days: offset),
    );
    final int weekLength = (endDate.difference(firstVisibleDate).inDays / 7)
        .ceil();

    return Column(
      children: List.generate(weekLength, (week) {
        return IntrinsicHeight(
          child: Row(
            children: List.generate(7, (day) {
              final date = firstVisibleDate.add(Duration(days: week * 7 + day));

              return Expanded(child: _buildDayCell(context, date));
            }),
          ),
        );
      }),
    );
  }

  Widget _buildDayCell(BuildContext context, DateTime date) {
    final dayEvents = events.where((e) => _isDateInRange(date, e.start, e.end));

    final backgroundColor = date.month % 2 == 0
        ? Colors.transparent
        : Theme.of(context).colorScheme.onSurface.withAlpha(15);

    return Container(
      color: backgroundColor,
      child: Opacity(
        opacity: _isDateInRange(date, startDate, endDate) ? 1.0 : 0.4,
        child: Column(
          children: [
            Text(
              '${date.day}',
              style: TextStyle(fontSize: 12, color: _getDayColor(date)),
            ),
            ...dayEvents.map(
              (e) => Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: e.color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  e.title,
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isDateInRange(DateTime target, DateTime start, DateTime end) {
    final t = DateTime(target.year, target.month, target.day);
    final s = DateTime(start.year, start.month, start.day);
    final e = DateTime(end.year, end.month, end.day);
    return t.compareTo(s) >= 0 && t.compareTo(e) <= 0;
  }

  Color? _getDayColor(DateTime date) {
    switch (WeekDay.fromDateTime(date)) {
      case WeekDay.sunday:
        return Colors.red;
      case WeekDay.saturday:
        return Colors.blue;
      default:
        return null;
    }
  }
}
