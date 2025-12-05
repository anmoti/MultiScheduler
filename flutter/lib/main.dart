import 'package:flutter/material.dart';
import 'package:multi_scheduler/router/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: .from(colorScheme: .fromSeed(seedColor: Colors.lightGreen)),
    );
  }
}
