import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:cazuela_chapina_app/src/features/auth/data/models/user_model.dart';
import 'package:cazuela_chapina_app/src/features/catalog/data/models/product_model.dart';

part 'sale_model.freezed.dart';
part 'sale_model.g.dart';

@freezed
class SaleModel with _$SaleModel {
  const factory SaleModel({
    required String id,
    required DateTime date,
    required String userId,
    required double total,
    UserModel? user,
    @Default([]) List<SaleItemModel> items,
  }) = _SaleModel;

  factory SaleModel.fromJson(Map<String, dynamic> json) =>
      _$SaleModelFromJson(json);
}

@freezed
class SaleItemModel with _$SaleItemModel {
  const factory SaleItemModel({
    required String productId,
    required int quantity,
    required double unitPrice,
    ProductModel? product,
  }) = _SaleItemModel;

  factory SaleItemModel.fromJson(Map<String, dynamic> json) =>
      _$SaleItemModelFromJson(json);
}
