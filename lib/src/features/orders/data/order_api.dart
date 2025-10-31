
import 'package:dio/dio.dart';

import 'models/order_model.dart';
import 'models/order_request.dart';

class OrderApi {
  OrderApi(this._dio);

  final Dio _dio;

  Future<List<OrderModel>> fetchOrders() async {
    final response = await _dio.get<Map<String, dynamic>>('/order');
    final data = response.data?['data'] as List<dynamic>? ?? const [];
    return data
        .map((item) => OrderModel.fromJson(
            Map<String, dynamic>.from(item as Map<dynamic, dynamic>)))
        .toList();
  }

  Future<OrderModel> createOrder(OrderRequest request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/order/create',
      data: request.toJson(),
    );
    final data = Map<String, dynamic>.from(
      (response.data?['data'] ?? {}) as Map<dynamic, dynamic>,
    );
    return OrderModel.fromJson(data);
  }

  Future<void> updateOrder({
    required String id,
    required OrderRequest request,
  }) async {
    await _dio.put<Map<String, dynamic>>(
      '/order/$id',
      data: request.toJson(),
    );
  }

  Future<void> deleteOrder(String id) async {
    await _dio.delete<Map<String, dynamic>>('/order/$id');
  }
}

