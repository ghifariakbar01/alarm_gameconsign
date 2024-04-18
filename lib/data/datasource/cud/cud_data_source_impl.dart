import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/appstring.dart';
import '../../../domain/dto/user_dto.dart';
import 'cud_data_source.dart';

final dio = Dio();

class CudDataSourceImpl implements CudDataSource {
  @override
  Future<Unit> postUser(UserDTO userDTO) async {
    final url = AppString.endPointUrl;
    try {
      await dio.post("$url/user", data: userDTO.toJson());

      return unit;
    } on DioException {
      rethrow;
    } catch (e) {
      throw e.toString();
    }
  }
}
