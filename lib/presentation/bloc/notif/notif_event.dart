// part of 'alarm_bloc.dart';

import 'package:flutter/material.dart';

import '../../../data/model/alarm_model.dart';

@immutable
abstract class NotifEvent {}

class ScheduleNotification extends NotifEvent {
  final AlarmModel alarm;
  ScheduleNotification(this.alarm);
}
