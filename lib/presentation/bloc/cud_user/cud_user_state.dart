import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/failure.dart';

part 'cud_user_state.freezed.dart';

@freezed
class CudUserState with _$CudUserState {
  const factory CudUserState.initial() = _Initial;
  const factory CudUserState.loading() = _Loading;
  const factory CudUserState.success() = _Success;
  const factory CudUserState.failure(Failure failure) = _Failure;
}
