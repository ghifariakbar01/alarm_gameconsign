import 'dart:convert';

import 'package:alarm/data/model/alarm_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../core/failure.dart';
import '../../domain/repository/alarm_repository.dart';

import '../datasource/alarm/alarm_data_source.dart';

class AlarmRepositoryImpl implements AlarmRepository {
  final AlarmDataSource _remoteDataSource;

  AlarmRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<AlarmModel>>> getAlarmListRepository() async {
    try {
      final result = await _remoteDataSource.get();

      if (result == null) {
        return const Right([]);
      } else {
        final js = jsonDecode(result);
        final res = (js as List).map((e) => AlarmModel.fromJson(e)).toList();

        return Right(res);
      }
    } catch (error) {
      return Left(OtherFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, AlarmModel>> getAlarmById(String id) async {
    try {
      final result = await _remoteDataSource.get();

      if (result == null) {
        return Left(OtherFailure('Alarm not found'));
      } else {
        final js = jsonDecode(result);
        final res = (js as List)
            .map((e) => AlarmModel.fromJson(e))
            .firstWhere((element) => element.id == id);

        return Right(res);
      }
    } catch (error) {
      return Left(OtherFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearRepository() async {
    try {
      await _remoteDataSource.clear();

      return const Right(unit);
    } catch (error) {
      return Left(OtherFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeRepository(String id) async {
    try {
      final result = await _remoteDataSource.get();

      if (result == null) {
        return const Right(unit);
      } else {
        final js = jsonDecode(result);
        final res = (js as List)
            .map((e) => AlarmModel.fromJson(e))
            .where((element) => element.id != id)
            .toList();

        final fin = jsonEncode(res);
        await _remoteDataSource.save(fin);

        return const Right(unit);
      }
    } catch (error) {
      return Left(OtherFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveRepository(AlarmModel alarm) async {
    try {
      final result = await _remoteDataSource.get();

      if (result == null) {
        final List<AlarmModel> list = [alarm];

        final fin = jsonEncode(list);
        await _remoteDataSource.save(fin);

        return const Right(unit);
      } else {
        final js = jsonDecode(result);
        final res = (js as List).map((e) => AlarmModel.fromJson(e)).toList();

        final List<AlarmModel> list = [...res, alarm];

        final fin = jsonEncode(list);
        await _remoteDataSource.save(fin);

        return const Right(unit);
      }
    } catch (error) {
      return Left(OtherFailure(error.toString()));
    }
  }
}
