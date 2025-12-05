import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_scheduler/router/router.dart';
import 'package:multi_scheduler/router/settings/settings_screen.dart';

class SettingsShellBranch extends StatefulShellBranchData {
  const SettingsShellBranch();
}

@immutable
class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(context, state) => const SettingsScreen();
}
