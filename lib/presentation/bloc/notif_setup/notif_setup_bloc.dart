import 'dart:developer';
import 'dart:io';

import 'package:alarm/core/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../data/datasource/notif/notif_data_source.dart';
import '../../../domain/dto/notif_dto.dart';
import 'notif_setup_event.dart';
import 'notif_setup_state.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz1;

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  log('notification(${notificationResponse.id}) action tapped: ');
  log('notification actionId ${notificationResponse.actionId} with');
  log('payload: ${notificationResponse.payload}');

  if (notificationResponse.input?.isNotEmpty ?? false) {}
}

class NotifSetupBloc extends Bloc<NotifSetupEvent, NotifSetupState> {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  NotifSetupBloc(this._flutterLocalNotificationsPlugin)
      : super(const NotifSetupState.loading()) {
    on<Setup>(
      (event, emit) => _onSetup(emit),
    );
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz1.setLocalLocation(tz1.getLocation(timeZoneName));
  }

  void _onSetup(
    Emitter<NotifSetupState> emit,
  ) async {
    emit(const NotifSetupState.loading());

    await _configureLocalTimeZone();

    final notifDataSource = NotifDataSource();

    final isPermitted = Platform.isIOS
        ? await _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            )
        : await _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();

    if (isPermitted == false) {
      emit(
          NotifSetupState.failure(OtherFailure('Notifications not permitted')));
    } else {
      final initializationSettingsDarwin = DarwinInitializationSettings(
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {
          notifDataSource.didReceiveLocalNotificationStream.add(
            ReceivedNotificationDto(
              id: id,
              title: title,
              body: body,
              payload: payload,
            ),
          );
        },
        notificationCategories: [
          DarwinNotificationCategory(
            'demoCategory',
            actions: <DarwinNotificationAction>[
              DarwinNotificationAction.plain('id_1', 'Action 1'),
              DarwinNotificationAction.plain('id_2', 'Action 2',
                  options: <DarwinNotificationActionOption>{
                    DarwinNotificationActionOption.destructive
                  }),
            ],
            options: <DarwinNotificationCategoryOption>{
              DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
            },
          )
        ],
      );

      const initializationSettingsAndroid =
          AndroidInitializationSettings('app_icon');

      final initializationSettings = InitializationSettings(
        iOS: initializationSettingsDarwin,
        android: initializationSettingsAndroid,
      );

      try {
        await _flutterLocalNotificationsPlugin.initialize(
          initializationSettings,
          onDidReceiveNotificationResponse:
              (NotificationResponse notificationResponse) {
            switch (notificationResponse.notificationResponseType) {
              case NotificationResponseType.selectedNotification:
                notifDataSource.selectNotificationStream
                    .add(notificationResponse.payload);
                break;
              case NotificationResponseType.selectedNotificationAction:
                if (notificationResponse.actionId == 'alarm_1') {
                  notifDataSource.selectNotificationStream
                      .add(notificationResponse.payload);
                }
                break;
            }
          },
          onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
        );
      } catch (e) {
        emit(NotifSetupState.failure(OtherFailure(e.toString())));
      }

      emit(const NotifSetupState.success());
    }
  }
}
