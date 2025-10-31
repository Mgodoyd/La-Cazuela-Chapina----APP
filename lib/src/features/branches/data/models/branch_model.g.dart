// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BranchModelImpl _$$BranchModelImplFromJson(Map<String, dynamic> json) =>
    _$BranchModelImpl(
      id: _readId(json, 'id') as String,
      name: _readName(json, 'name') as String,
      address: _readAddress(json, 'address') as String,
      phone: _readPhone(json, 'phone') as String,
    );

Map<String, dynamic> _$$BranchModelImplToJson(_$BranchModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
    };
