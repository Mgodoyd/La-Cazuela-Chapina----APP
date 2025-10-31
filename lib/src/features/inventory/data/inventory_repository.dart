import 'inventory_api.dart';
import 'models/inventory_item_model.dart';
import 'models/inventory_movement_model.dart';
import 'models/raw_material_model.dart';
import 'models/raw_material_request.dart';

class InventoryRepository {
  InventoryRepository(this._api);

  final InventoryApi _api;

  Future<List<InventoryItemModel>> fetchInventory() => _api.fetchInventory();

  Future<InventoryItemModel> fetchItem(String rawMaterialId) =>
      _api.fetchItem(rawMaterialId);

  Future<RawMaterialModel> createRawMaterial(RawMaterialRequest request) =>
      _api.createRawMaterial(request);

  Future<RawMaterialModel> updateRawMaterial({
    required String rawMaterialId,
    required RawMaterialRequest request,
  }) => _api.updateRawMaterial(rawMaterialId: rawMaterialId, request: request);

  Future<void> deleteRawMaterial(String rawMaterialId) =>
      _api.deleteRawMaterial(rawMaterialId);

  Future<void> registerMovement({
    required String rawMaterialId,
    required InventoryMovementModel movement,
  }) => _api.registerMovement(rawMaterialId: rawMaterialId, movement: movement);
}
