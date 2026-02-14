import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:multi_scheduler/api/dio_client.dart';

import 'package:multi_scheduler/api/generated/models/calendar_public.dart';

import 'package:multi_scheduler/data/repositories/calendar_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _repository = CalendarRepository(client);
  List<CalendarPublic> _calendars = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCalendars();
    calendarNotifier.addListener(_onCalendarChanged);
  }

  @override
  void dispose() {
    calendarNotifier.removeListener(_onCalendarChanged);
    super.dispose();
  }

  void _onCalendarChanged() {
    _fetchCalendars();
  }

  Future<void> _fetchCalendars() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final calendars = await _repository.listCalendars();
      setState(() {
        _calendars = calendars;
      });
    } catch (e) {
      // TODO: エラーハンドリング
      log(error: e, 'カレンダーの取得に失敗しました');
    } finally {
      setState(() {
        _isLoading = false;
      });
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

  Future<void> _deleteCalendar(CalendarPublic calendar) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('カレンダー削除'),
          content: Text('「${calendar.name}」を削除しますか？'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('削除'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      try {
        await _repository.deleteCalendar(calendar.id);
        _fetchCalendars();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('削除に失敗しました: $e')));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ホーム')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchCalendars,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    'カレンダー',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  if (_calendars.isEmpty)
                    const Text('カレンダーがありません')
                  else
                    ..._calendars.map(
                      (calendar) => Card(
                        child: ListTile(
                          title: Text(calendar.name),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () => _deleteCalendar(calendar),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _createCalendar,
                    icon: const Icon(Icons.add),
                    label: const Text('カレンダーを作成'),
                  ),
                ],
              ),
            ),
    );
  }
}
