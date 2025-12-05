import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_scheduler/router/home/home_screen.dart';
import 'package:multi_scheduler/router/router.dart';

class HomeShellBranch extends StatefulShellBranchData {
  const HomeShellBranch();
}

@immutable
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(context, state) => const HomeScreen();
}
