// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProductModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  int get stock => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  ProductCategory get category => throw _privateConstructorUsedError;
  TamalAttributes? get tamal => throw _privateConstructorUsedError;
  BeverageAttributes? get beverage => throw _privateConstructorUsedError;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductModelCopyWith<ProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductModelCopyWith<$Res> {
  factory $ProductModelCopyWith(
    ProductModel value,
    $Res Function(ProductModel) then,
  ) = _$ProductModelCopyWithImpl<$Res, ProductModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    double price,
    bool active,
    int stock,
    DateTime createdAt,
    ProductCategory category,
    TamalAttributes? tamal,
    BeverageAttributes? beverage,
  });
}

/// @nodoc
class _$ProductModelCopyWithImpl<$Res, $Val extends ProductModel>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? active = null,
    Object? stock = null,
    Object? createdAt = null,
    Object? category = null,
    Object? tamal = freezed,
    Object? beverage = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
            stock: null == stock
                ? _value.stock
                : stock // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as ProductCategory,
            tamal: freezed == tamal
                ? _value.tamal
                : tamal // ignore: cast_nullable_to_non_nullable
                      as TamalAttributes?,
            beverage: freezed == beverage
                ? _value.beverage
                : beverage // ignore: cast_nullable_to_non_nullable
                      as BeverageAttributes?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductModelImplCopyWith<$Res>
    implements $ProductModelCopyWith<$Res> {
  factory _$$ProductModelImplCopyWith(
    _$ProductModelImpl value,
    $Res Function(_$ProductModelImpl) then,
  ) = __$$ProductModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    double price,
    bool active,
    int stock,
    DateTime createdAt,
    ProductCategory category,
    TamalAttributes? tamal,
    BeverageAttributes? beverage,
  });
}

/// @nodoc
class __$$ProductModelImplCopyWithImpl<$Res>
    extends _$ProductModelCopyWithImpl<$Res, _$ProductModelImpl>
    implements _$$ProductModelImplCopyWith<$Res> {
  __$$ProductModelImplCopyWithImpl(
    _$ProductModelImpl _value,
    $Res Function(_$ProductModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? active = null,
    Object? stock = null,
    Object? createdAt = null,
    Object? category = null,
    Object? tamal = freezed,
    Object? beverage = freezed,
  }) {
    return _then(
      _$ProductModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
        stock: null == stock
            ? _value.stock
            : stock // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as ProductCategory,
        tamal: freezed == tamal
            ? _value.tamal
            : tamal // ignore: cast_nullable_to_non_nullable
                  as TamalAttributes?,
        beverage: freezed == beverage
            ? _value.beverage
            : beverage // ignore: cast_nullable_to_non_nullable
                  as BeverageAttributes?,
      ),
    );
  }
}

/// @nodoc

class _$ProductModelImpl extends _ProductModel {
  const _$ProductModelImpl({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.active,
    required this.stock,
    required this.createdAt,
    this.category = ProductCategory.generic,
    this.tamal,
    this.beverage,
  }) : super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final double price;
  @override
  final bool active;
  @override
  final int stock;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final ProductCategory category;
  @override
  final TamalAttributes? tamal;
  @override
  final BeverageAttributes? beverage;

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, description: $description, price: $price, active: $active, stock: $stock, createdAt: $createdAt, category: $category, tamal: $tamal, beverage: $beverage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.stock, stock) || other.stock == stock) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.tamal, tamal) || other.tamal == tamal) &&
            (identical(other.beverage, beverage) ||
                other.beverage == beverage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    price,
    active,
    stock,
    createdAt,
    category,
    tamal,
    beverage,
  );

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      __$$ProductModelImplCopyWithImpl<_$ProductModelImpl>(this, _$identity);
}

abstract class _ProductModel extends ProductModel {
  const factory _ProductModel({
    required final String id,
    required final String name,
    required final String description,
    required final double price,
    required final bool active,
    required final int stock,
    required final DateTime createdAt,
    final ProductCategory category,
    final TamalAttributes? tamal,
    final BeverageAttributes? beverage,
  }) = _$ProductModelImpl;
  const _ProductModel._() : super._();

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  double get price;
  @override
  bool get active;
  @override
  int get stock;
  @override
  DateTime get createdAt;
  @override
  ProductCategory get category;
  @override
  TamalAttributes? get tamal;
  @override
  BeverageAttributes? get beverage;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
