import 'dart:async';

import 'package:flutter/material.dart';

import 'package:accurative/core/injection.dart' as di;

import 'core/navigation.dart';

import 'presentation/page/home_page.dart';

final pageRoutes = di.sl<PageRoutes>();

void main() {
  runZonedGuarded(() async {
    di.init();
    runApp(
      const MyApp(),
    );
  }, (error, stack) {
    // implement error / crashylytics here
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: pageRoutes.onGenerateRoute,
      home: const HomePage(),
    );
  }
}
