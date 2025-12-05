import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_scheduler/router/router.dart';
import 'package:multi_scheduler/router/tasks/tasks_screen.dart';

class TasksShellBranch extends StatefulShellBranchData {
  const TasksShellBranch();
}

@immutable
class TasksRoute extends GoRouteData with $TasksRoute {
  const TasksRoute();

  @override
  Widget build(context, state) => const TasksScreen();
}
