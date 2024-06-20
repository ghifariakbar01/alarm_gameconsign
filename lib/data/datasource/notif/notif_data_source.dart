import 'dart:async';

import 'package:get/get.dart';

import '../../../core/routes.dart';
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

      await Get.toNamed(Routes.detailPage, arguments: payload);
    });
  }

  void configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream
        .listen((ReceivedNotificationDto receivedNotificationDto) async {});
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
