import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../core/constants/api_const.dart';
import '../../../core/utils/secure_storage_service.dart';
import '../model/sale_model.dart';

class SaleService {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 5),
    )
  );
  final SecureStorageService _storage = SecureStorageService();

  Future<(List<SaleModel>?, String?)> fetchSales({
    required int pageNumber,
    int itemsPerPage = 20,
    String? search,
  }) async {
    try {
      final token = await _storage.getToken();
      final userId = await _storage.getUserId();
      if (token == null || userId == null) return (null, 'Unauthorized');

      final response = await _dio.post(
        ApiConst.saleListPage,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {
          "BranchID": 1,
          "CompanyID": "1901b825-fe6f-418d-b5f0-7223d0040d08",
          "CreatedUserID": int.tryParse(userId) ?? 1,
          "PriceRounding": 2,
          "page_no": pageNumber,
          "items_per_page": itemsPerPage,
          "type": "Sales",
          "WarehouseID": 1,
          if (search != null && search.isNotEmpty) "search": search,
        },
      );
      if (response.statusCode == 200) {
        final List datas = response.data['data']['data'];
        final data = datas.map((e) => SaleModel.fromJson(e)).toList();
        return (data, null);
      }
      debugPrint("failed to fech data: ${response.statusCode}");
      return (null, '${response.statusCode} - failed to fech data');
    } on DioException catch (e) {
      return (null, e.toString());
    }
  }
}
