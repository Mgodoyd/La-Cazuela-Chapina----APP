// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryItemModelImpl _$$InventoryItemModelImplFromJson(
  Map<String, dynamic> json,
) => _$InventoryItemModelImpl(
  id: json['id'] as String?,
  rawMaterial: RawMaterialModel.fromJson(
    json['rawMaterial'] as Map<String, dynamic>,
  ),
  currentQuantity: (json['currentQuantity'] as num).toDouble(),
);

Map<String, dynamic> _$$InventoryItemModelImplToJson(
  _$InventoryItemModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'rawMaterial': instance.rawMaterial,
  'currentQuantity': instance.currentQuantity,
};
