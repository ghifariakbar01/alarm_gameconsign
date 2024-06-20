// part of 'alarm_bloc.dart';

import 'package:flutter/material.dart';

import '../../../data/model/alarm_model.dart';

@immutable
abstract class CudAlarmEvent {}

class DeleteAlarm extends CudAlarmEvent {
  final AlarmModel alarm;
  DeleteAlarm(this.alarm);
}

class ClearAlarm extends CudAlarmEvent {
  ClearAlarm();
}

class SaveAlarm extends CudAlarmEvent {
  final AlarmModel alarm;
  SaveAlarm(this.alarm);
}
