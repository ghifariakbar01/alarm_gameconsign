import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repository/alarm_repository.dart';

import 'cud_alarm_event.dart';
import 'cud_alarm_state.dart';

class CudAlarmBloc extends Bloc<CudAlarmEvent, CudAlarmState> {
  final AlarmRepository _repository;

  CudAlarmBloc(this._repository) : super(const CudAlarmState.initial()) {
    on<DeleteAlarm>(
      (event, emit) => _onDeleteAlarm(event, emit),
    );
    on<ClearAlarm>(
      (event, emit) => _onClearAlarm(event, emit),
    );
    on<SaveAlarm>(
      (event, emit) => _onSaveAlarm(event, emit),
    );
  }

  void _onDeleteAlarm(
    DeleteAlarm event,
    Emitter<CudAlarmState> emit,
  ) async {
    emit(const CudAlarmState.loading());

    final result = await _repository.removeRepository(event.alarm.id!);

    result.fold(
      (l) => emit(CudAlarmState.failure(l)),
      (r) => emit(const CudAlarmState.success()),
    );
  }

  void _onClearAlarm(
    ClearAlarm event,
    Emitter<CudAlarmState> emit,
  ) async {
    emit(const CudAlarmState.loading());

    final result = await _repository.clearRepository();

    result.fold(
      (l) => emit(CudAlarmState.failure(l)),
      (r) => emit(const CudAlarmState.success()),
    );
  }

  void _onSaveAlarm(
    SaveAlarm event,
    Emitter<CudAlarmState> emit,
  ) async {
    emit(const CudAlarmState.loading());

    final result = await _repository.saveRepository(event.alarm);

    result.fold(
      (l) => emit(CudAlarmState.failure(l)),
      (r) => emit(const CudAlarmState.success()),
    );
  }
}
