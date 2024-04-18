import 'dart:async';

import 'package:flutter/material.dart';

import 'package:accurative/core/injection.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import 'core/navigation.dart';

import 'core/providers.dart';
import 'core/routes.dart';
import 'presentation/page/home_page.dart';

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
    return MultiBlocProvider(
      providers: Providers(context).providers,
      child: GetMaterialApp(
        initialRoute: Routes.homePage,
        unknownRoute: PageRoutes.unknownPage(),
        getPages: PageRoutes.pages(),
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
