import 'package:dartz/dartz.dart';

import '../../../domain/dto/user_dto.dart';

abstract class CudDataSource {
  Future<Unit> postUser(UserDTO userDTO);
}
