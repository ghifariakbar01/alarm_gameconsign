import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/route_manager.dart';

import 'core/navigation.dart';

import 'core/providers.dart';
import 'core/routes.dart';
import 'data/datasource/notif/notif_data_source.dart';
import 'presentation/page/home_page.dart';

import 'package:alarm/core/injection.dart' as di;

import 'style/style.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

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
    NotifDataSource().listenNotif();
  }

  @override
  void dispose() {
    NotifDataSource().closeNotif();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: Providers(context).providers,
      child: GetMaterialApp(
        initialRoute: Routes.homePage,
        unknownRoute: PageRoutes.unknownPage(),
        getPages: PageRoutes.pages(),
        theme: Themes.darkTheme(context),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
