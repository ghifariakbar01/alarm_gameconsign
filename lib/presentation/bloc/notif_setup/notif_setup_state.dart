import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/failure.dart';

part 'notif_setup_state.freezed.dart';

@freezed
class NotifSetupState with _$NotifSetupState {
  const factory NotifSetupState.loading() = _Loading;
  const factory NotifSetupState.success() = _Data;
  const factory NotifSetupState.failure(Failure failure) = _Failure;
}
