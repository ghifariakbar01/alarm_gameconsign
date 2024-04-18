import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/failure.dart';
import '../../domain/repository/cud_repository.dart';

import '../datasource/cud/cud_data_source.dart';
import '../../domain/dto/user_dto.dart';

class CudRepositoryImpl implements CudRepository {
  final CudDataSource _remoteDataSource;

  CudRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, Unit>> postUserRepository(UserDTO userDTO) async {
    try {
      final result = await _remoteDataSource.postUser(userDTO);
      return Right(result);
    } on DioException catch (dioError) {
      return Left(DioFailure(dioError));
    } catch (error) {
      return Left(OtherFailure(error.toString()));
    }
  }
}
