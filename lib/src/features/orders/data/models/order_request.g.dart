// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderRequestImpl _$$OrderRequestImplFromJson(Map<String, dynamic> json) =>
    _$OrderRequestImpl(
      userId: json['UserId'] as String,
      status: json['Status'] as String,
      confirmed: json['Confirmed'] as bool,
      stock: (json['Stock'] as num).toInt(),
      items:
          (json['Items'] as List<dynamic>?)
              ?.map((e) => OrderItemRequest.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: json['CreatedAt'] == null
          ? null
          : DateTime.parse(json['CreatedAt'] as String),
    );

Map<String, dynamic> _$$OrderRequestImplToJson(_$OrderRequestImpl instance) =>
    <String, dynamic>{
      'UserId': instance.userId,
      'Status': instance.status,
      'Confirmed': instance.confirmed,
      'Stock': instance.stock,
      'Items': instance.items,
      'CreatedAt': instance.createdAt?.toIso8601String(),
    };

_$OrderItemRequestImpl _$$OrderItemRequestImplFromJson(
  Map<String, dynamic> json,
) => _$OrderItemRequestImpl(
  productId: json['ProductId'] as String,
  quantity: (json['Quantity'] as num).toInt(),
  unitPrice: (json['UnitPrice'] as num).toDouble(),
);

Map<String, dynamic> _$$OrderItemRequestImplToJson(
  _$OrderItemRequestImpl instance,
) => <String, dynamic>{
  'ProductId': instance.productId,
  'Quantity': instance.quantity,
  'UnitPrice': instance.unitPrice,
};
