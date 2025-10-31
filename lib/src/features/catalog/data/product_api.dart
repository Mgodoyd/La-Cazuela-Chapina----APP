import 'package:dio/dio.dart';

import '../data/models/product_model.dart';
import '../../../features/combos/data/models/combo_model.dart';

class ProductApi {
  ProductApi(this._dio);
  final Dio _dio;

  Future<List<ProductModel>> fetchProducts() async {
    final resp = await _dio.get<Map<String, dynamic>>('/product');
    final list = resp.data?['data'] as List<dynamic>? ?? [];
    return list
        .map((e) => ProductModel.fromJson(
            Map<String, dynamic>.from(e as Map<dynamic, dynamic>)))
        .toList();
  }

  Future<List<ComboModel>> fetchCombos() async {
    final resp = await _dio.get<Map<String, dynamic>>('/combos');
    final list = resp.data?['data'] as List<dynamic>? ?? [];
    return list
        .map((e) => ComboModel.fromJson(
            Map<String, dynamic>.from(e as Map<dynamic, dynamic>)))
        .toList();
  }

  Future<ProductModel> createProduct(Map<String, dynamic> data) async {
    final resp = await _dio.post<Map<String, dynamic>>(
      '/product/create',
      data: data,
    );
    final json = Map<String, dynamic>.from(
      (resp.data?['data'] ?? {}) as Map<dynamic, dynamic>,
    );
    return ProductModel.fromJson(json);
  }

  Future<void> updateProduct(String id, Map<String, dynamic> data) async {
    await _dio.put<Map<String, dynamic>>('/product/$id', data: data);
  }

  Future<void> deleteProduct(String id) async {
    await _dio.delete<Map<String, dynamic>>('/product/$id');
  }
}

