import 'dart:async';

import 'package:flutter/material.dart';

import 'package:accurative/core/injection.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/injection.dart';
import 'core/navigation.dart';

import 'presentation/bloc/cud_user/cud_user_bloc.dart';
import 'presentation/bloc/user/user_bloc.dart';
import 'presentation/cubit/filter_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<FilterCubit>(
          create: (BuildContext context) => FilterCubit(),
        ),
        BlocProvider<CudUserBloc>(
          create: (BuildContext context) => CudUserBloc(sl()),
        ),
        BlocProvider<UserBloc>(
          create: (BuildContext context) => userSl..add(GetUser()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        onGenerateRoute: pageRoutes.onGenerateRoute,
        home: const HomePage(),
      ),
    );
  }
}
