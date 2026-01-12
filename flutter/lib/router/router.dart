import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_scheduler/router/home/home_route.dart';
import 'package:multi_scheduler/router/scaffold_with_navbar.dart';
import 'package:multi_scheduler/router/schedule/schedule_route.dart';
import 'package:multi_scheduler/router/auth/login_screen.dart';
import 'package:multi_scheduler/router/auth/signup_screen.dart';
import 'package:multi_scheduler/router/settings/settings_route.dart';
import 'package:multi_scheduler/router/tasks/tasks_route.dart';

part 'router.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  routes: [
    ...$appRoutes,
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (context, state) => const SignupScreen()),
  ],
  initialLocation: HomeRoute().location,
  navigatorKey: rootNavigatorKey,
);

@TypedStatefulShellRoute<AppShellRouteData>(
  branches: [
    homeStatefulShellBranch,
    tasksStatefulShellBranch,
    scheduleStatefulShellBranch,
    settingsStatefulShellBranch,
  ],
)
class AppShellRouteData extends StatefulShellRouteData {
  const AppShellRouteData();

  @override
  Widget builder(context, state, navigationShell) {
    return ScaffoldWithNavBar(navigationShell: navigationShell);
  }
}

const homeStatefulShellBranch = TypedStatefulShellBranch<HomeShellBranch>(
  routes: [TypedGoRoute<HomeRoute>(path: '/home', routes: [])],
);

const tasksStatefulShellBranch = TypedStatefulShellBranch<TasksShellBranch>(
  routes: [TypedGoRoute<TasksRoute>(path: '/tasks', routes: [])],
);

const scheduleStatefulShellBranch =
    TypedStatefulShellBranch<ScheduleShellBranch>(
      routes: [TypedGoRoute<ScheduleRoute>(path: '/schedule', routes: [])],
    );

const settingsStatefulShellBranch =
    TypedStatefulShellBranch<SettingsShellBranch>(
      routes: [TypedGoRoute<SettingsRoute>(path: '/settings', routes: [])],
    );
