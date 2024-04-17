import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/model/user_model.dart';
import '../../domain/repository/user_repository.dart';
import 'user_state.dart';

part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _repository;

  UserBloc(this._repository) : super(const UserState.loading()) {
    on<GetUser>(
      (event, emit) => _onGetUserList(emit),
    );
    on<SearchByName>(
      (event, emit) => _onSearchUserList(event, emit),
    );
    on<SortByName>(
      (event, emit) => _onSortByName(event, emit),
    );
    on<FilterByCity>(
      (event, emit) => _onFilterByCity(event, emit),
    );
  }

  void _onGetUserList(
    Emitter<UserState> emit,
  ) async {
    emit(const UserState.loading());

    final result = await _repository.getUserListRepository();

    result.fold(
        //
        (l) => emit(UserState.failure(l)),
        (r) => emit(UserState.data(r)));
  }

  void _onSearchUserList(
    SearchByName event,
    Emitter<UserState> emit,
  ) {
    state.maybeWhen(
        data: (val) {
          final filtered = val
              .where((user) => user.name.toLowerCase().contains(event.nama))
              .toList();

          emit(UserState.data(filtered));
        },
        orElse: () {});
  }

  void _onSortByName(
    SortByName event,
    Emitter<UserState> emit,
  ) {
    state.maybeWhen(
        data: (val) {
          List<UserModel> sortedList = [];

          if (event.isReverse) {
            sortedList = List.from(val.reversed);

            emit(UserState.data(sortedList));
          } else {
            sortedList = List.from(val)
              ..sort((a, b) => a.name
                  .toLowerCase()
                  .compareTo(b.name.toLowerCase().toString()));

            emit(UserState.data(sortedList));
          }
        },
        orElse: () {});
  }

  void _onFilterByCity(
    FilterByCity event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserState.loading());

    final result = await _repository.getUserListRepository();

    result.fold((l) => emit(UserState.failure(l)), (r) {
      if (r.isEmpty) {
        return;
      }

      final List<String> cities = event.cities;
      final filtered = r
          .where((element) => cities.contains(element.city.toLowerCase()))
          .toList();

      emit(UserState.data(filtered));
    });
  }
}
