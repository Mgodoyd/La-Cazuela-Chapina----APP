import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: invalid_annotation_target

import 'package:cazuela_chapina_app/src/features/catalog/data/models/product_model.dart';

part 'combo_model.freezed.dart';
part 'combo_model.g.dart';

@freezed
class ComboModel with _$ComboModel {
  const factory ComboModel({
    @JsonKey(readValue: _readId) required String id,
    @JsonKey(readValue: _readName) required String name,
    @JsonKey(readValue: _readDescription) required String description,
    required double price,
    required bool editable,
    @Default([]) List<ComboProduct> products,
  }) = _ComboModel;

  factory ComboModel.fromJson(Map<String, dynamic> json) =>
      _$ComboModelFromJson(json);
}

Object? _readId(Map json, String key) => json['Id'] ?? json['id'] ?? '';
Object? _readName(Map json, String key) => json['Name'] ?? json['name'] ?? '';
Object? _readDescription(Map json, String key) => json['Description'] ?? json['description'] ?? '';

@freezed
class ComboProduct with _$ComboProduct {
  const factory ComboProduct({
    @JsonKey(readValue: _readComboId) required String comboId,
    @JsonKey(readValue: _readProductId) required String productId,
    required int quantity,
    ProductModel? product,
  }) = _ComboProduct;

  factory ComboProduct.fromJson(Map<String, dynamic> json) =>
      _$ComboProductFromJson(json);
}

Object? _readComboId(Map json, String key) => json['ComboId'] ?? json['comboId'] ?? '';
Object? _readProductId(Map json, String key) => json['ProductId'] ?? json['productId'] ?? '';




