
import 'package:dio/dio.dart';

import 'models/sale_model.dart';
import 'models/sale_request.dart';

class SaleApi {
  SaleApi(this._dio);

  final Dio _dio;

  Future<List<SaleModel>> fetchSales() async {
    final response = await _dio.get<Map<String, dynamic>>('/sale');
    final data = response.data?['data'] as List<dynamic>? ?? const [];
    return data
        .map((item) => SaleModel.fromJson(
            Map<String, dynamic>.from(item as Map<dynamic, dynamic>)))
        .toList();
  }

  Future<SaleModel> createSale(SaleRequest request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/sale/create',
      data: request.toJson(),
    );
    final data = Map<String, dynamic>.from(
      (response.data?['data'] ?? {}) as Map<dynamic, dynamic>,
    );
    return SaleModel.fromJson(data);
  }
}

