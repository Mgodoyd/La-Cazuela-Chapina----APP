import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: invalid_annotation_target

part 'inventory_movement_model.freezed.dart';
part 'inventory_movement_model.g.dart';

@freezed
class InventoryMovementModel with _$InventoryMovementModel {
  const factory InventoryMovementModel({
    required String type,
    required double quantity,
    double? cost,
    String? reason,
  }) = _InventoryMovementModel;

  factory InventoryMovementModel.fromJson(Map<String, dynamic> json) =>
      _$InventoryMovementModelFromJson(json);
}
