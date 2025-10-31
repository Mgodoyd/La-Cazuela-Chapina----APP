// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'combo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ComboModelImpl _$$ComboModelImplFromJson(Map<String, dynamic> json) =>
    _$ComboModelImpl(
      id: _readId(json, 'id') as String,
      name: _readName(json, 'name') as String,
      description: _readDescription(json, 'description') as String,
      price: (json['price'] as num).toDouble(),
      editable: json['editable'] as bool,
      products:
          (json['products'] as List<dynamic>?)
              ?.map((e) => ComboProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ComboModelImplToJson(_$ComboModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'editable': instance.editable,
      'products': instance.products,
    };

_$ComboProductImpl _$$ComboProductImplFromJson(Map<String, dynamic> json) =>
    _$ComboProductImpl(
      comboId: _readComboId(json, 'comboId') as String,
      productId: _readProductId(json, 'productId') as String,
      quantity: (json['quantity'] as num).toInt(),
      product: json['product'] == null
          ? null
          : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ComboProductImplToJson(_$ComboProductImpl instance) =>
    <String, dynamic>{
      'comboId': instance.comboId,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'product': instance.product,
    };
