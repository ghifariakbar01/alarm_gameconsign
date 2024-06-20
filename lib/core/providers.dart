import 'package:alarm/presentation/bloc/alarm/alarm_bloc.dart';
import 'package:alarm/presentation/bloc/alarm/alarm_event.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/bloc/notif/notif_bloc.dart';
import '../presentation/bloc/notif_setup/notif_setup_bloc.dart';

import '../presentation/bloc/notif_setup/notif_setup_event.dart';

import 'injection.dart';

class Providers {
  final BuildContext context;

  Providers(this.context);

  List<BlocProvider> get providers => _providers;

  final List<BlocProvider> _providers = [
    BlocProvider<NotifBloc>(
      create: (BuildContext context) => NotifBloc(sl()),
    ),
    BlocProvider<AlarmBloc>(
      create: (BuildContext context) => alarmSl..add(GetAlarm()),
    ),
    BlocProvider<NotifSetupBloc>(
      create: (BuildContext context) => notifSetupSl..add(Setup()),
    ),
  ];
}
