import 'package:alarm/core/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import 'notif_event.dart';
import 'notif_state.dart';

import 'package:timezone/timezone.dart' as tz;

class NotifBloc extends Bloc<NotifEvent, NotifState> {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  NotifBloc(this._flutterLocalNotificationsPlugin)
      : super(const NotifState.loading()) {
    on<ScheduleNotification>(
      (event, emit) => _onScheduleNotification(event, emit),
    );
  }

  void _onScheduleNotification(
    ScheduleNotification event,
    Emitter<NotifState> emit,
  ) async {
    emit(const NotifState.loading());

    try {
      final alarm = event.alarm;

      await _flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        alarm.nama,
        'Alarm ini dijadwalkan jam ${DateFormat('HH:mm a').format(alarm.date)}',
        _tzByDateTime(alarm.date),
        payload: alarm.id,
        const NotificationDetails(
            android: AndroidNotificationDetails('alarm_1', 'alarm_channel',
                channelDescription: 'showed scheduled alarm notif',
                actions: [
              AndroidNotificationAction(
                'alarm_1',
                'Action 3',
                icon: DrawableResourceAndroidBitmap('app_icon'),
                showsUserInterface: true,
                cancelNotification: false,
              ),
            ])),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      emit(NotifState.failure(OtherFailure(e.toString())));
    }

    emit(const NotifState.success());
  }

  tz.TZDateTime _tzByDateTime(DateTime date) {
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      date.year,
      date.month,
      date.day,
      date.hour,
      date.minute,
    );

    return scheduledDate;
  }
}
