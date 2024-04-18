import 'package:dio/dio.dart';

import '../../../core/appstring.dart';
import '../../model/user_model.dart';
import 'user_data_source.dart';

final dio = Dio();

class UserDataSourceImpl implements UserDataSource {
  @override
  Future<List<UserModel>> getUserList() async {
    final url = AppString.endPointUrl;
    try {
      final response = await dio.get("$url/user");
      final result = (response.data as List)
          .map((e) => UserModel.fromMap(e as Map<String, dynamic>))
          .toList();
      return result;
    } on DioException {
      rethrow;
    } catch (e) {
      throw e.toString();
    }
  }
}
