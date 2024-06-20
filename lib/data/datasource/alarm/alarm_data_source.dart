import 'package:fpdart/fpdart.dart';

abstract class AlarmDataSource {
  Future<String?> get();
  Future<Unit> save(String json);
  Future<Unit> clear();
}
