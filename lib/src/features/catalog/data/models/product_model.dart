import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';

enum ProductCategory { tamal, beverage, generic }

@freezed
class ProductModel with _$ProductModel {
  const ProductModel._();

  const factory ProductModel({
    required String id,
    required String name,
    required String description,
    required double price,
    required bool active,
    required int stock,
    required DateTime createdAt,
    @Default(ProductCategory.generic) ProductCategory category,
    TamalAttributes? tamal,
    BeverageAttributes? beverage,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final id = (json['Id'] ?? json['id'] ?? '').toString();
    final name = (json['Name'] ?? json['name'] ?? '').toString();
    final description =
        (json['Description'] ?? json['description'] ?? '').toString();
    final price = (json['Price'] ?? json['price'] ?? 0) as num;
    final active = (json['Active'] ?? json['active'] ?? true) as bool;
    final stock = (json['Stock'] ?? json['stock'] ?? 0) as int;
    final createdAtString = (json['CreatedAt'] ?? json['createdAt'] ?? '').toString();
    final createdAt = createdAtString.isNotEmpty 
        ? DateTime.parse(createdAtString)
        : DateTime.now();

    final tamalData = json['DoughType'] != null || json['doughType'] != null
        ? TamalAttributes.fromJson(json)
        : null;
    final beverageData =
        json['Sweetener'] != null || json['sweetener'] != null || json['Type'] != null
            ? BeverageAttributes.fromJson(json)
            : null;

    final category = tamalData != null
        ? ProductCategory.tamal
        : beverageData != null
            ? ProductCategory.beverage
            : ProductCategory.generic;

    return ProductModel(
      id: id,
      name: name,
      description: description,
      price: price.toDouble(),
      active: active,
      stock: stock,
      createdAt: createdAt,
      category: category,
      tamal: tamalData,
      beverage: beverageData,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'Id': id,
      'Name': name,
      'Description': description,
      'Price': price,
      'Active': active,
      'Stock': stock,
      'CreatedAt': createdAt.toIso8601String(),
    };
    if (tamal != null) {
      data.addAll(tamal!.toJson());
    }
    if (beverage != null) {
      data.addAll(beverage!.toJson());
    }
    return data;
  }
}

@immutable
class TamalAttributes {
  const TamalAttributes({
    required this.doughType,
    required this.filling,
    required this.wrapper,
    required this.spiceLevel,
  });

  final String doughType;
  final String filling;
  final String wrapper;
  final String spiceLevel;

  factory TamalAttributes.fromJson(Map<String, dynamic> json) => TamalAttributes(
        doughType: (json['DoughType'] ?? json['doughType'] ?? '') as String,
        filling: (json['Filling'] ?? json['filling'] ?? '') as String,
        wrapper: (json['Wrapper'] ?? json['wrapper'] ?? '') as String,
        spiceLevel: (json['SpiceLevel'] ?? json['spiceLevel'] ?? '') as String,
      );

  Map<String, dynamic> toJson() => {
        'DoughType': doughType,
        'Filling': filling,
        'Wrapper': wrapper,
        'SpiceLevel': spiceLevel,
      };
}

@immutable
class BeverageAttributes {
  const BeverageAttributes({
    required this.type,
    required this.sweetener,
    this.topping,
    required this.size,
  });

  final String type;
  final String sweetener;
  final String? topping;
  final String size;

  factory BeverageAttributes.fromJson(Map<String, dynamic> json) =>
      BeverageAttributes(
        type: (json['Type'] ?? json['type'] ?? '') as String,
        sweetener: (json['Sweetener'] ?? json['sweetener'] ?? '') as String,
        topping: json['Topping'] as String?,
        size: (json['Size'] ?? json['size'] ?? '') as String,
      );

  Map<String, dynamic> toJson() => {
        'Type': type,
        'Sweetener': sweetener,
        if (topping != null) 'Topping': topping,
        'Size': size,
      };
}



