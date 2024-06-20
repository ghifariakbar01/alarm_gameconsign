import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/failure.dart';
import '../../../data/model/alarm_model.dart';

part 'alarm_state.freezed.dart';

@freezed
class AlarmState with _$AlarmState {
  const factory AlarmState.loading() = _Loading;
  const factory AlarmState.data(List<AlarmModel> data) = _Data;
  const factory AlarmState.failure(Failure failure) = _Failure;
}
