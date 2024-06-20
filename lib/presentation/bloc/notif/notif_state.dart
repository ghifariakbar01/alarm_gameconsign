import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/failure.dart';

part 'notif_state.freezed.dart';

@freezed
class NotifState with _$NotifState {
  const factory NotifState.loading() = _Loading;
  const factory NotifState.success() = _Success;
  const factory NotifState.failure(Failure failure) = _Failure;
}
