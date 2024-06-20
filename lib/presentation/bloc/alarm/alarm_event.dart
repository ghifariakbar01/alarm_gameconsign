// part of 'alarm_bloc.dart';

import 'package:flutter/material.dart';

@immutable
abstract class AlarmEvent {}

class GetAlarm extends AlarmEvent {
  GetAlarm();
}

class GetAlarmById extends AlarmEvent {
  final String id;
  GetAlarmById(this.id);
}
