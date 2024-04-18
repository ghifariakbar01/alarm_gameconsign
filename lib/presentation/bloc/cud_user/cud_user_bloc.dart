import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/dto/user_dto.dart';
import '../../../domain/repository/cud_repository.dart';
import 'cud_user_state.dart';

part 'cud_user_event.dart';

class CudUserBloc extends Bloc<CudUserEvent, CudUserState> {
  final CudRepository _repository;

  CudUserBloc(this._repository) : super(const CudUserState.initial()) {
    on<CreateUser>(
      (event, emit) => _createUser(event, emit),
    );
    /* 
        add update, delete method here
    */
  }

  void _createUser(
    CreateUser event,
    Emitter<CudUserState> emit,
  ) async {
    emit(const CudUserState.loading());

    final UserDTO user = event.userDTO;

    final result = await _repository.postUserRepository(user);

    result.fold((l) => emit(CudUserState.failure(l)),
        (_) => emit(const CudUserState.success()));
  }
}
