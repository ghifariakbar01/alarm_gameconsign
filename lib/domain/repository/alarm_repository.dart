import 'package:fpdart/fpdart.dart';

import '../../core/failure.dart';

import '../../data/model/alarm_model.dart';

abstract class AlarmRepository {
  Future<Either<Failure, List<AlarmModel>>> getAlarmListRepository();
  Future<Either<Failure, AlarmModel>> getAlarmById(String id);
  Future<Either<Failure, Unit>> saveRepository(AlarmModel alarm);
  Future<Either<Failure, Unit>> removeRepository(String id);
  Future<Either<Failure, Unit>> clearRepository();
}
