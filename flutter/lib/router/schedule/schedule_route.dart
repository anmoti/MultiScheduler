import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_scheduler/router/router.dart';
import 'package:multi_scheduler/router/schedule/schedule_screen.dart';

class ScheduleShellBranch extends StatefulShellBranchData {
  const ScheduleShellBranch();
}

@immutable
class ScheduleRoute extends GoRouteData with $ScheduleRoute {
  const ScheduleRoute();

  @override
  Widget build(context, state) => const ScheduleScreen();
}
