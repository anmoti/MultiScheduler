import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_scheduler/router/auth/login_screen.dart';
import 'package:multi_scheduler/router/auth/signup_screen.dart';

part 'auth_router.g.dart';

List<RouteBase> get $authRoutes => $appRoutes;

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return LoginScreen();
  }
}

@TypedGoRoute<SignupRoute>(path: '/signup')
class SignupRoute extends GoRouteData with $SignupRoute {
  const SignupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SignupScreen();
  }
}
