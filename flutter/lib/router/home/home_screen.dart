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
                    'カレンダー一覧',
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
                          subtitle: Text(calendar.id),
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
