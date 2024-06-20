import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';

import 'alarm_data_source.dart';

class AlarmDataSourceImpl implements AlarmDataSource {
  final FlutterSecureStorage _storage;

  AlarmDataSourceImpl(this._storage);

  final key = 'alarm';

  @override
  Future<String?> get() async {
    return _storage.read(key: key);
  }

  @override
  Future<Unit> clear() async {
    await _storage.delete(key: key);
    return unit;
  }

  @override
  Future<Unit> save(String json) async {
    await _storage.write(
      key: key,
      value: json,
    );

    return unit;
  }
}
