import 'package:dio/dio.dart';

import 'models/inventory_item_model.dart';
import 'models/inventory_movement_model.dart';
import 'models/raw_material_model.dart';
import 'models/raw_material_request.dart';

class InventoryApi {
  InventoryApi(this._dio);

  final Dio _dio;

  Future<List<InventoryItemModel>> fetchInventory() async {
    final response = await _dio.get<Map<String, dynamic>>('/inventory');
    final data = response.data?['data'] as List<dynamic>? ?? const [];
    return data
        .map(
          (item) => InventoryItemModel.fromJson(
            Map<String, dynamic>.from(item as Map<dynamic, dynamic>),
          ),
        )
        .toList();
  }

  Future<InventoryItemModel> fetchItem(String rawMaterialId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/inventory/$rawMaterialId',
    );
    final data = Map<String, dynamic>.from(
      (response.data?['data'] ?? {}) as Map<dynamic, dynamic>,
    );
    return InventoryItemModel.fromJson(data);
  }

  Future<RawMaterialModel> createRawMaterial(RawMaterialRequest request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/inventory/create',
      data: request.toJson(),
    );
    final data = Map<String, dynamic>.from(
      (response.data?['data'] ?? {}) as Map<dynamic, dynamic>,
    );
    return RawMaterialModel.fromJson(data);
  }

  Future<RawMaterialModel> updateRawMaterial({
    required String rawMaterialId,
    required RawMaterialRequest request,
  }) async {
    final response = await _dio.put<Map<String, dynamic>>(
      '/inventory/$rawMaterialId',
      data: request.toJson(),
    );
    final data = Map<String, dynamic>.from(
      (response.data?['data'] ?? {}) as Map<dynamic, dynamic>,
    );
    return RawMaterialModel.fromJson(data);
  }

  Future<void> deleteRawMaterial(String rawMaterialId) async {
    await _dio.delete<Map<String, dynamic>>('/inventory/$rawMaterialId');
  }

  Future<void> registerMovement({
    required String rawMaterialId,
    required InventoryMovementModel movement,
  }) async {
    await _dio.post<Map<String, dynamic>>(
      '/inventory/$rawMaterialId/movement',
      data: movement.toJson(),
    );
  }
}
