import 'package:flutter/material.dart';
import 'package:multi_scheduler/helper/time.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  static const WeekDay _startOfWeek = WeekDay.sunday;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarHeader(startOfWeek: _startOfWeek),
        CalendarRangeView(
          startOfWeek: _startOfWeek,
          startDate: DateTime(2025, 11, 7),
          endDate: DateTime(2025, 12, 1),
        ),
      ],
    );
  }
}

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({required this.startOfWeek, super.key});

  final WeekDay startOfWeek;

  @override
  Widget build(BuildContext context) {
    WeekDay weekDay = startOfWeek;

    return Container(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (
              int i = 0;
              i == 0 || weekDay != startOfWeek;
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

              if (weekDay != startOfWeek.previous())
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
      case WeekDay.saturday:
        return Colors.blue;
      case WeekDay.sunday:
        return Colors.red;
      default:
        return null; // テーマのデフォルト色を使用
    }
  }
}

class CalendarRangeView extends StatelessWidget {
  CalendarRangeView({
    required this.startOfWeek,
    required this.startDate,
    required this.endDate,
    super.key,
  });

  final WeekDay startOfWeek;
  final DateTime startDate;
  final DateTime endDate;

  final List<Event> events = [
    Event(
      'ミーティング1',
      DateTime(2025, 11, 30, 10, 0),
      DateTime(2025, 11, 30, 12, 0),
      Colors.blue,
    ),
    Event(
      '旅行',
      DateTime(2025, 11, 1, 9, 0),
      DateTime(2025, 12, 3, 10, 0),
      Colors.purple,
    ),
    Event(
      'ランチ1',
      DateTime(2025, 12, 1, 12, 0),
      DateTime(2025, 12, 1, 13, 0),
      Colors.green,
    ),
    Event(
      'ミーティング2',
      DateTime(2025, 12, 2, 14, 0),
      DateTime(2025, 12, 4, 15, 30),
      Colors.blue,
    ),
    Event(
      'ランチ2',
      DateTime(2025, 12, 2, 12, 0),
      DateTime(2025, 12, 2, 13, 0),
      Colors.green,
    ),
  ];

  static const double _dateHeaderHeight = 20.0;
  static const double _eventHeight = 20.0;
  static const double _eventMargin = 2.0;
  static const double _outOfRangeOpacity = 0.4;

  @override
  Widget build(BuildContext context) {
    final int offset = startOfWeek.differenceFromDate(startDate);
    final int weekLength = ((offset + endDate.difference(startDate).inDays) / 7)
        .ceil();

    return Column(
      children: List.generate(weekLength, (i) {
        final weekStartTime = startDate.add(Duration(days: (i * 7) - offset));

        return _buildWeekRow(context, weekStartTime);
      }),
    );
  }

  Widget _buildWeekRow(BuildContext context, DateTime weekStartTime) {
    final weekEndTime = weekStartTime.add(
      const Duration(days: 7, microseconds: -1),
    );

    // イベントをフィルタリング
    final weekEvents = events
        .where((e) => e.isInclude(weekStartTime, weekEndTime))
        .toList();

    // イベントの表示位置を計算
    final layoutEvents = _calculateEventLayout(
      weekEvents,
      weekStartTime,
      weekEndTime,
    );

    final laneLength = layoutEvents.fold(
      2,
      (prev, e) => e.lane + 1 > prev ? e.lane + 1 : prev,
    );
    final rowHeight =
        _dateHeaderHeight + laneLength * (_eventHeight + _eventMargin);

    return SizedBox(
      height: rowHeight,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(7, (dayIndex) {
              final date = weekStartTime.add(Duration(days: dayIndex));
              return Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: date.month % 2 == 0
                        ? Colors.transparent
                        : Theme.of(context).colorScheme.onSurface.withAlpha(15),
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Opacity(
                        opacity: isIncludeTime(date, startDate, endDate)
                            ? 1.0
                            : _outOfRangeOpacity,
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                            fontSize: 12,
                            color: _getDayColor(date),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),

          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final dayWidth = constraints.maxWidth / 7;

              return Stack(
                children: layoutEvents.map((layoutEvent) {
                  return _buildEventWidget(
                    layoutEvent: layoutEvent,
                    dayWidth: dayWidth,
                    weekStartTime: weekStartTime,
                    weekEndTime: weekEndTime,
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  /// イベントの重複を計算し、表示するレーンを割り当てる
  List<_LayoutEvent> _calculateEventLayout(
    List<Event> events,
    DateTime weekStartTime,
    DateTime weekEndTime,
  ) {
    // 開始日時が早い、期間が長い順にソートする
    events.sort((a, b) {
      int result = a.start.compareTo(b.start);
      if (result == 0) return b.end.compareTo(a.end);

      return result;
    });

    final List<_LayoutEvent> layoutEvents = [];

    // 各レーンの最後の日付を保持するリスト (indexがレーン番号)
    final List<DateTime> lanesLastDate = [];

    for (final event in events) {
      final startTime = event.start.isBefore(weekStartTime)
          ? weekStartTime
          : event.start;
      final endTime = event.end.isAfter(weekEndTime) ? weekEndTime : event.end;

      final startDate = DateTime(
        startTime.year,
        startTime.month,
        startTime.day,
      );
      final endDate = DateTime(endTime.year, endTime.month, endTime.day);

      final offsetDays = startDate.difference(weekStartTime).inDays;
      int durationDays = endDate.difference(startDate).inDays + 1;
      // durationがはみ出る場合の補正
      if ((offsetDays + durationDays) > 7) {
        durationDays = 7 - offsetDays;
      }

      // 空いているレーンを探す
      int laneIndex = -1;
      for (int i = 0; i < lanesLastDate.length; i++) {
        // このレーンの最終予定より、今回の開始日時が後なら置ける
        if (lanesLastDate[i].isBefore(startDate)) {
          laneIndex = i;
          lanesLastDate[i] = endDate;
          break;
        }
      }

      // 空きレーンがなければ新しいレーンを追加
      if (laneIndex == -1) {
        laneIndex = lanesLastDate.length;
        lanesLastDate.add(endDate);
      }

      layoutEvents.add(
        _LayoutEvent(
          event: event,
          offsetDays: offsetDays,
          durationDays: durationDays,
          lane: laneIndex,
        ),
      );
    }

    return layoutEvents;
  }

  Widget _buildEventWidget({
    required _LayoutEvent layoutEvent,
    required double dayWidth,
    required DateTime weekStartTime,
    required DateTime weekEndTime,
  }) {
    final event = layoutEvent.event;

    final top =
        _dateHeaderHeight + (layoutEvent.lane * (_eventHeight + _eventMargin));

    final left = layoutEvent.offsetDays * dayWidth;
    final width = layoutEvent.durationDays * dayWidth;

    final hoge1 = event.start.isBefore(weekStartTime);
    final hoge2 = event.end.isAfter(weekEndTime);

    return Positioned(
      top: top,
      left: left,
      width: width,
      height: _eventHeight,
      child: Container(
        margin: EdgeInsets.only(left: hoge1 ? 0 : 2, right: hoge2 ? 0 : 2),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: event.color,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(hoge1 ? 0 : 4),
            right: Radius.circular(hoge2 ? 0 : 4),
          ),
        ),
        child: Text(
          event.title,
          style: const TextStyle(color: Colors.white, fontSize: 12),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
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

// レイアウト計算用の内部クラス
class _LayoutEvent {
  final Event event;
  final int offsetDays;
  final int durationDays;
  final int lane;

  _LayoutEvent({
    required this.event,
    required this.offsetDays,
    required this.durationDays,
    required this.lane,
  });
}
