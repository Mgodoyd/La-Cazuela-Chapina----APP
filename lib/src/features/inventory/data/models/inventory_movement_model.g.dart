// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_movement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryMovementModelImpl _$$InventoryMovementModelImplFromJson(
  Map<String, dynamic> json,
) => _$InventoryMovementModelImpl(
  type: json['type'] as String,
  quantity: (json['quantity'] as num).toDouble(),
  cost: (json['cost'] as num?)?.toDouble(),
  reason: json['reason'] as String?,
);

Map<String, dynamic> _$$InventoryMovementModelImplToJson(
  _$InventoryMovementModelImpl instance,
) => <String, dynamic>{
  'type': instance.type,
  'quantity': instance.quantity,
  'cost': instance.cost,
  'reason': instance.reason,
};
