import 'package:alarm/data/datasource/alarm/alarm_data_source.dart';
import 'package:alarm/data/datasource/alarm/alarm_data_source_impl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../data/repository/alarm_repository_impl.dart';

import '../domain/repository/alarm_repository.dart';

import '../presentation/bloc/alarm/alarm_bloc.dart';
import '../presentation/bloc/cud_alarm/cud_alarm_bloc.dart';

import '../presentation/bloc/notif/notif_bloc.dart';

import '../presentation/bloc/notif_setup/notif_setup_bloc.dart';

import 'appstring.dart';
import 'navigation.dart';

final sl = GetIt.instance;

/*
  Notif & Alarm
*/
final notifSl = sl<NotifBloc>();
final alarmSl = sl<AlarmBloc>();
final cudSl = sl<CudAlarmBloc>();
/*
  Storage
*/
final storageSl = sl<FlutterSecureStorage>();
/*
  Permission
*/
final notifSetupSl = sl<NotifSetupBloc>();

void init() {
  sl
    ..registerLazySingleton(() => AppString())
    ..registerLazySingleton(() => PageRoutes())
    ..registerLazySingleton<FlutterSecureStorage>(
        () => const FlutterSecureStorage(
                aOptions: AndroidOptions(
              encryptedSharedPreferences: true,
            )))
    ..registerLazySingleton<FlutterLocalNotificationsPlugin>(
        () => FlutterLocalNotificationsPlugin())

    //* Alarm
    ..registerLazySingleton<AlarmDataSource>(
        () => AlarmDataSourceImpl(storageSl))
    ..registerLazySingleton<AlarmRepository>(() => AlarmRepositoryImpl(sl()))
    ..registerLazySingleton(() => AlarmBloc(sl()))
    //* CUD Alarm
    ..registerLazySingleton(() => CudAlarmBloc(sl()))
    //* Notification
    ..registerLazySingleton(() => NotifBloc(sl()))
    ..registerLazySingleton(() => NotifSetupBloc(sl()));
}
