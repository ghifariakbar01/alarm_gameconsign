import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:accurative/data/model/user_model.dart';

import '../../core/failure.dart';
import '../../domain/repository/user_repository.dart';
import '../datasource/user_data_source.dart';

class UserDataRepositoryImpl implements UserRepository {
  final UserDataSource _remoteDataSource;

  UserDataRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<UserModel>>> getUserListRepository() async {
    try {
      final result = await _remoteDataSource.getUserListDataSource();
      return Right(result);
    } on DioException catch (dioError) {
      return Left(DioFailure(dioError));
    } catch (error) {
      return Left(OtherFailure(error.toString()));
    }
  }
}
