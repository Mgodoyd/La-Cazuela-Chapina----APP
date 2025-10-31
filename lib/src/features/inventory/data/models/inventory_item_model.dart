import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: invalid_annotation_target

import 'raw_material_model.dart';

part 'inventory_item_model.freezed.dart';
part 'inventory_item_model.g.dart';

@freezed
class InventoryItemModel with _$InventoryItemModel {
  const factory InventoryItemModel({
    String? id,
    required RawMaterialModel rawMaterial,
    required double currentQuantity,
  }) = _InventoryItemModel;

  factory InventoryItemModel.fromJson(Map<String, dynamic> json) =>
      _$InventoryItemModelFromJson(json);
}
