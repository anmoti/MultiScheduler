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
        MonthView(firstDayOfWeek: _firstDayOfWeek, year: 2025, month: 12),
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
    required this.year,
    required this.month,
    super.key,
  });

  final WeekDay firstDayOfWeek;
  final int year;
  final int month;

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
    DateTime day = DateTime(year, month, 1);
    day = day.subtract(
      Duration(days: (day.weekday % 7 - firstDayOfWeek.id + 7) % 7),
    );

    return Column(
      children: [
        for (int week = 0; week < 6; week++)
          IntrinsicHeight(
            child: Expanded(
              child: Row(
                children: [
                  for (
                    int i = 0;
                    i < 7;
                    i++, day = day.add(const Duration(days: 1))
                  ) ...[
                    Expanded(
                      child: Opacity(
                        opacity: day.month == month ? 1.0 : 0.4,
                        child: Column(
                          children: [
                            Text(
                              '${day.day}',
                              style: TextStyle(
                                fontSize: 12,
                                color: _getDayColor(WeekDay.fromDateTime(day)),
                              ),
                            ),
                            for (Event event in events.where((event) {
                              final eventStart = DateTime(
                                event.start.year,
                                event.start.month,
                                event.start.day,
                              );
                              final eventEnd = DateTime(
                                event.end.year,
                                event.end.month,
                                event.end.day,
                              );
                              final currentDay = DateTime(
                                day.year,
                                day.month,
                                day.day,
                              );

                              // 現在のセル(currentDay)が、イベント期間内(start以上 end以下)に含まれるか判定
                              return currentDay.compareTo(eventStart) >= 0 &&
                                  currentDay.compareTo(eventEnd) <= 0;
                            }))
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 2),
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: event.color,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  event.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (i < 6)
                      VerticalDivider(
                        width: 1,
                        thickness: 1,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }

  Color? _getDayColor(WeekDay weekDay) {
    switch (weekDay) {
      case WeekDay.sunday:
        return Colors.red;
      case WeekDay.saturday:
        return Colors.blue;
      default:
        return null;
    }
  }
}
