part of 'cud_user_bloc.dart';

@immutable
abstract class CudUserEvent {}

class CreateUser extends CudUserEvent {
  final UserDTO userDTO;
  CreateUser({required this.userDTO});
}
