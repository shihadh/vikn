import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../core/constants/api_const.dart';
import '../../../core/utils/secure_storage_service.dart';
import '../model/profile_model.dart';

class ProfileService {
  final Dio _dio = Dio();
  final SecureStorageService _storage = SecureStorageService();

  Future<(ProfileModel?, String?)> fetchProfile() async {
    try {
      final token = await _storage.getToken();
      final userId = await _storage.getUserId();
      if (token == null || userId == null) return (null, 'Unauthorized');

      final response = await _dio.get(
        ApiConst.userView(userId),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        final data = response.data['data'];
        return (ProfileModel.fromJson(data), null);
      }
      debugPrint("failed to fech data: ${response.statusCode}");
      return (null, '${response.statusCode} - failed to fech data');
    } on DioException catch (e) {
      return (null, e.toString());
    }
  }
}
