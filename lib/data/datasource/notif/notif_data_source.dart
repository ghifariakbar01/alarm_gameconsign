import 'dart:async';

import 'package:alarm/core/injection.dart';
import 'package:alarm/presentation/bloc/notif_setup/notif_setup_event.dart';

import '../../../domain/dto/notif_dto.dart';

class NotifDataSource {
  final didReceiveLocalNotificationStream =
      StreamController<ReceivedNotificationDto>.broadcast();
  final selectNotificationStream = StreamController<String?>.broadcast();

  void configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {
      if (payload == null) {
        return;
      }

      notifSetupSl.add(Setup());
    });
  }

  void configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream
        .listen((ReceivedNotificationDto receivedNotificationDto) async {
      notifSetupSl.add(Setup());
    });
  }

  listenNotif() {
    configureDidReceiveLocalNotificationSubject();
    configureSelectNotificationSubject();
  }

  closeNotif() {
    didReceiveLocalNotificationStream.close();
    selectNotificationStream.close();
  }
}
