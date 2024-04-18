import 'package:flutter_bloc/flutter_bloc.dart';

class FilterCubit extends Cubit<List<String>> {
  FilterCubit() : super([]);

  void addCity(String name) => emit([...state, name]);

  void removeCity(String name) =>
      emit([...state.where((element) => element != name)]);
}
