import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: invalid_annotation_target

part 'order_request.freezed.dart';
part 'order_request.g.dart';

@freezed
class OrderRequest with _$OrderRequest {
  const factory OrderRequest({
    @JsonKey(name: 'UserId') required String userId,
    @JsonKey(name: 'Status') required String status,
    @JsonKey(name: 'Confirmed') required bool confirmed,
    @JsonKey(name: 'Stock') required int stock,
    @JsonKey(name: 'Items') @Default([]) List<OrderItemRequest> items,
    @JsonKey(name: 'CreatedAt') DateTime? createdAt,
  }) = _OrderRequest;

  factory OrderRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestFromJson(json);
}

@freezed
class OrderItemRequest with _$OrderItemRequest {
  const factory OrderItemRequest({
    @JsonKey(name: 'ProductId') required String productId,
    @JsonKey(name: 'Quantity') required int quantity,
    @JsonKey(name: 'UnitPrice') required double unitPrice,
  }) = _OrderItemRequest;

  factory OrderItemRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderItemRequestFromJson(json);
}
