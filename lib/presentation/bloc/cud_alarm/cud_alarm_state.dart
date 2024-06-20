import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/failure.dart';

part 'cud_alarm_state.freezed.dart';

@freezed
class CudAlarmState with _$CudAlarmState {
  const factory CudAlarmState.initial() = _Initial;
  const factory CudAlarmState.loading() = _Loading;
  const factory CudAlarmState.success() = _Success;
  const factory CudAlarmState.failure(Failure failure) = _Failure;
}
