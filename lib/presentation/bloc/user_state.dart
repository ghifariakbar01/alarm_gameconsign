import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/failure.dart';
import '../../data/model/user_model.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.loading() = _Loading;
  const factory UserState.data(List<UserModel> user) = _Data;
  const factory UserState.failure(Failure failure) = _Failure;
}
