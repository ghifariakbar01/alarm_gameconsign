part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class GetUser extends UserEvent {
  GetUser();
}

class SearchByName extends UserEvent {
  final String nama;
  SearchByName(this.nama);
}

class SortByName extends UserEvent {
  final bool isReverse;
  SortByName({required this.isReverse});
}

class FilterByCity extends UserEvent {
  final List<String> cities;
  FilterByCity({required this.cities});
}
