import 'package:dartz/dartz.dart';

import '../../core/failure.dart';

import '../dto/user_dto.dart';

abstract class CudRepository {
  Future<Either<Failure, Unit>> postUserRepository(UserDTO userDTO);
}
