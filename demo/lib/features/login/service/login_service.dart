import 'package:dio/dio.dart';
import '../../../core/constants/api_const.dart';
import 'package:flutter/foundation.dart';
import '../model/login_model.dart';

class LoginService {
  final Dio _dio = Dio();

  Future<(LoginModel?, String?)> login(String username, String password) async {
    try {
      final response = await _dio.post(
        ApiConst.login,
        data: {
          "username": username,
          "password": password,
          "is_mobile": true,
        },
      );
      if (response.statusCode == 200) {
        final data = response.data;
        return (LoginModel.fromJson(data), null);
      }
      debugPrint("failed to fech data: ${response.statusCode}");
      return (null, '${response.statusCode} - failed to fech data');
    } on DioException catch (e) {
      return (null, e.toString());
    }
  }
}
