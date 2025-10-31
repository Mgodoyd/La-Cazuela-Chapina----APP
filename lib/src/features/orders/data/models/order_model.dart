import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cazuela_chapina_app/src/features/auth/data/models/user_model.dart';
import 'package:cazuela_chapina_app/src/features/catalog/data/models/product_model.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class OrderModel with _$OrderModel {
  const factory OrderModel({
    required String id,
    required String userId,
    required DateTime createdAt,
    required String status,
    required bool confirmed,
    required int stock,
    UserModel? user,
    @Default([]) List<OrderItemModel> items,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}

@freezed
class OrderItemModel with _$OrderItemModel {
  const factory OrderItemModel({
    required String productId,
    required int quantity,
    required double unitPrice,
    ProductModel? product,
  }) = _OrderItemModel;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);
}
