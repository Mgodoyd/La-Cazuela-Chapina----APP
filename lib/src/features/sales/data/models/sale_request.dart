import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale_request.freezed.dart';

@Freezed(toJson: false, fromJson: false)
class SaleRequest with _$SaleRequest {
  const SaleRequest._();

  const factory SaleRequest({
    required String userId,
    required double total,
    @Default([]) List<SaleItemRequest> items,
    required DateTime date,
  }) = _SaleRequest;

  factory SaleRequest.fromJson(Map<String, dynamic> json) => SaleRequest(
        userId: (json['userId'] ?? json['userId']) as String,
        total: ((json['total'] ?? json['total']) as num).toDouble(),
        items: ((json['items'] ?? json['items']) as List<dynamic>? ?? [])
            .map(
              (item) => SaleItemRequest.fromJson(
                Map<String, dynamic>.from(item as Map<dynamic, dynamic>),
              ),
            )
            .toList(),
        date: DateTime.parse(json['date'] as String),
      );

  Map<String, dynamic> toJson() {
        final d = date;
        if (d == null) throw ArgumentError.notNull('date');
        return {
          'date': d.toIso8601String(),
          'userId': userId,
          'total': total,
          'items': items.map((item) => item.toJson()).toList(),
        };
      }
}

@Freezed(toJson: false, fromJson: false)
class SaleItemRequest with _$SaleItemRequest {
  const SaleItemRequest._();

  const factory SaleItemRequest({
    required String productId,
    required int quantity,
    required double unitPrice,
  }) = _SaleItemRequest;

  factory SaleItemRequest.fromJson(Map<String, dynamic> json) =>
      SaleItemRequest(
        productId: (json['productId'] ?? json['productId']) as String,
        quantity: (json['quantity'] ?? json['quantity']) as int,
        unitPrice: ((json['unitPrice'] ?? json['unitPrice']) as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'quantity': quantity,
        'unitPrice': unitPrice,
      };
}




