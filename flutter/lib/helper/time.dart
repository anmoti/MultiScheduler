import 'dart:ui';

class Event {
  final String title;
  final DateTime start;
  final DateTime end;
  final Color color;

  Event(this.title, this.start, this.end, this.color);
}

enum WeekDay {
  sunday(0, '日', 'Sun'),
  monday(1, '月', 'Mon'),
  tuesday(2, '火', 'Tue'),
  wednesday(3, '水', 'Wed'),
  thursday(4, '木', 'Thu'),
  friday(5, '金', 'Fri'),
  saturday(6, '土', 'Sat');

  const WeekDay(this.id, this.ja, this.en);

  final int id;
  final String ja;
  final String en;

  WeekDay previous({int step = 1}) {
    return next(step: -step);
  }

  WeekDay next({int step = 1}) {
    return WeekDay.fromId((id + step) % 7);
  }

  static WeekDay fromId(int id) {
    return WeekDay.values.firstWhere((day) => day.id == id);
  }

  static WeekDay fromDateTime(DateTime dateTime) {
    return fromId(dateTime.weekday % 7);
  }
}
