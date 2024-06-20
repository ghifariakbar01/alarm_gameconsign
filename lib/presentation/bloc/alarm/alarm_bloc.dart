import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repository/alarm_repository.dart';
import 'alarm_event.dart';
import 'alarm_state.dart';

class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  final AlarmRepository _repository;

  AlarmBloc(this._repository) : super(const AlarmState.loading()) {
    on<GetAlarm>(
      (event, emit) => _onGetAlarmList(emit),
    );
    on<GetAlarmById>(
      (event, emit) => _onGetAlarmById(event, emit),
    );
  }

  void _onGetAlarmList(
    Emitter<AlarmState> emit,
  ) async {
    emit(const AlarmState.loading());

    final result = await _repository.getAlarmListRepository();

    result.fold(
      (l) => emit(AlarmState.failure(l)),
      (r) => emit(AlarmState.data(r)),
    );
  }

  void _onGetAlarmById(
    GetAlarmById event,
    Emitter<AlarmState> emit,
  ) async {
    emit(const AlarmState.loading());

    final result = await _repository.getAlarmById(event.id);

    result.fold(
      (l) => emit(AlarmState.failure(l)),
      (r) => emit(AlarmState.data([r])),
    );
  }
}
