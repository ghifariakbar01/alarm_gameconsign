// part of 'alarm_bloc.dart';

import 'package:flutter/material.dart';

@immutable
abstract class NotifSetupEvent {}

class Setup extends NotifSetupEvent {
  Setup();
}
