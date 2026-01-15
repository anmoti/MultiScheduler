import 'package:flutter/material.dart';
import 'package:multi_scheduler/api/dio_client.dart';
import 'package:multi_scheduler/router/schedule/components/calendar_widget.dart';

import 'package:multi_scheduler/api/generated/models/calendar_public.dart';
import 'package:multi_scheduler/data/repositories/calendar_repository.dart';
import 'package:multi_scheduler/helper/time.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final _repository = CalendarRepository(client);
  List<CalendarPublic> _calendars = [];
  CalendarPublic? _selectedCalendar;
  List<Event> _events = [];

  @override
  void initState() {
    super.initState();
    _fetchCalendars();
  }

  Future<void> _fetchCalendars() async {
    try {
      final calendars = await _repository.listCalendars();
      setState(() {
        _calendars = calendars;
        if (calendars.isNotEmpty) {
          _selectedCalendar = calendars.first;
          _fetchEvents(calendars.first.id);
        } else {
          _selectedCalendar = null;
          _events = [];
        }
      });
    } catch (e) {
      // TODO: エラーハンドリング
      print(e);
    }
  }

  Future<void> _createCalendar() async {
    final TextEditingController controller = TextEditingController();
    final String? name = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('カレンダー作成'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'カレンダー名'),
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text('作成'),
            ),
          ],
        );
      },
    );

    if (name != null && name.isNotEmpty) {
      try {
        await _repository.createCalendar(name);
        _fetchCalendars();
      } catch (e) {
        // TODO: エラーハンドリング
        print(e);
      }
    }
  }

  Future<void> _fetchEvents(String calendarId) async {
    try {
      final events = await _repository.listEvents(calendarId);
      setState(() {
        _events = events
            .map(
              (e) => Event(
                e.title,
                e.startAt ?? DateTime.now(), // TODO: nullの場合はどうするか
                e.endAt ?? DateTime.now().add(const Duration(hours: 1)),
                Colors.blue, // TODO: カレンダーの色を使う？
              ),
            )
            .toList();
      });
    } catch (e) {
      // TODO: エラーハンドリング
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _calendars.isEmpty
            ? const Text('MultiScheduler')
            : DropdownButton<CalendarPublic>(
                value: _selectedCalendar,
                onChanged: (CalendarPublic? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedCalendar = newValue;
                    });
                    _fetchEvents(newValue.id);
                  }
                },
                items: _calendars.map<DropdownMenuItem<CalendarPublic>>((
                  CalendarPublic value,
                ) {
                  return DropdownMenuItem<CalendarPublic>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
              ),
        actions: [
          IconButton(
            onPressed: () {
              _fetchCalendars();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _calendars.isEmpty
          ? Center(
              child: ElevatedButton(
                onPressed: _createCalendar,
                child: const Text('カレンダーを作成'),
              ),
            )
          : CalendarWidget(events: _events),
    );
  }
}
