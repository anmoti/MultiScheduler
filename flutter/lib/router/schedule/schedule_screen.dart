import 'package:flutter/material.dart';
import 'package:multi_scheduler/router/schedule/components/calendar_widget.dart';

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
