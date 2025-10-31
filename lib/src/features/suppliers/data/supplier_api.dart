import 'package:dio/dio.dart';

import 'models/supplier_model.dart';
import 'models/supplier_request.dart';

class SupplierApi {
  SupplierApi(this._dio);

  final Dio _dio;

  Future<List<SupplierModel>> fetchSuppliers() async {
    final response = await _dio.get<Map<String, dynamic>>('/supplier');
    final list = response.data?['data'] as List<dynamic>? ?? [];
    return list
        .map(
          (item) => SupplierModel.fromJson(
            Map<String, dynamic>.from(item as Map<dynamic, dynamic>),
          ),
        )
        .toList();
  }

  Future<SupplierModel> createSupplier(SupplierRequest request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/supplier/create',
      data: request.toJson(),
    );
    final data = Map<String, dynamic>.from(
      (response.data?['data'] ?? {}) as Map<dynamic, dynamic>,
    );
    return SupplierModel.fromJson(data);
  }

  Future<void> updateSupplier({
    required String id,
    required SupplierRequest request,
  }) async {
    await _dio.put<void>('/supplier/$id', data: request.toJson());
  }

  Future<void> deleteSupplier(String id) async {
    await _dio.delete<void>('/supplier/$id');
  }
}
