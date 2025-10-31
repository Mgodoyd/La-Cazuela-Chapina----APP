// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_material_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RawMaterialModelImpl _$$RawMaterialModelImplFromJson(
  Map<String, dynamic> json,
) => _$RawMaterialModelImpl(
  id: json['id'] as String?,
  name: json['name'] as String,
  unit: json['unit'] as String,
  minStock: (json['minStock'] as num).toDouble(),
);

Map<String, dynamic> _$$RawMaterialModelImplToJson(
  _$RawMaterialModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'unit': instance.unit,
  'minStock': instance.minStock,
};
