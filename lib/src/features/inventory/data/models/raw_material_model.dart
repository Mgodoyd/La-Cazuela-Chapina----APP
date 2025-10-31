import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: invalid_annotation_target

part 'raw_material_model.freezed.dart';
part 'raw_material_model.g.dart';

@freezed
class RawMaterialModel with _$RawMaterialModel {
  const factory RawMaterialModel({
    String? id,
    required String name,
    required String unit,
    required double minStock,
  }) = _RawMaterialModel;

  factory RawMaterialModel.fromJson(Map<String, dynamic> json) =>
      _$RawMaterialModelFromJson(json);
}
