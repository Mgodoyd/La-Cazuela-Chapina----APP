// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'combo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ComboModel _$ComboModelFromJson(Map<String, dynamic> json) {
  return _ComboModel.fromJson(json);
}

/// @nodoc
mixin _$ComboModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  bool get editable => throw _privateConstructorUsedError;
  List<ComboProduct> get products => throw _privateConstructorUsedError;

  /// Serializes this ComboModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ComboModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ComboModelCopyWith<ComboModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComboModelCopyWith<$Res> {
  factory $ComboModelCopyWith(
    ComboModel value,
    $Res Function(ComboModel) then,
  ) = _$ComboModelCopyWithImpl<$Res, ComboModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    double price,
    bool editable,
    List<ComboProduct> products,
  });
}

/// @nodoc
class _$ComboModelCopyWithImpl<$Res, $Val extends ComboModel>
    implements $ComboModelCopyWith<$Res> {
  _$ComboModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ComboModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? editable = null,
    Object? products = null,
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
            editable: null == editable
                ? _value.editable
                : editable // ignore: cast_nullable_to_non_nullable
                      as bool,
            products: null == products
                ? _value.products
                : products // ignore: cast_nullable_to_non_nullable
                      as List<ComboProduct>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ComboModelImplCopyWith<$Res>
    implements $ComboModelCopyWith<$Res> {
  factory _$$ComboModelImplCopyWith(
    _$ComboModelImpl value,
    $Res Function(_$ComboModelImpl) then,
  ) = __$$ComboModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    double price,
    bool editable,
    List<ComboProduct> products,
  });
}

/// @nodoc
class __$$ComboModelImplCopyWithImpl<$Res>
    extends _$ComboModelCopyWithImpl<$Res, _$ComboModelImpl>
    implements _$$ComboModelImplCopyWith<$Res> {
  __$$ComboModelImplCopyWithImpl(
    _$ComboModelImpl _value,
    $Res Function(_$ComboModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ComboModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? editable = null,
    Object? products = null,
  }) {
    return _then(
      _$ComboModelImpl(
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
        editable: null == editable
            ? _value.editable
            : editable // ignore: cast_nullable_to_non_nullable
                  as bool,
        products: null == products
            ? _value._products
            : products // ignore: cast_nullable_to_non_nullable
                  as List<ComboProduct>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ComboModelImpl implements _ComboModel {
  const _$ComboModelImpl({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.editable,
    final List<ComboProduct> products = const [],
  }) : _products = products;

  factory _$ComboModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComboModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final double price;
  @override
  final bool editable;
  final List<ComboProduct> _products;
  @override
  @JsonKey()
  List<ComboProduct> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString() {
    return 'ComboModel(id: $id, name: $name, description: $description, price: $price, editable: $editable, products: $products)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComboModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.editable, editable) ||
                other.editable == editable) &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    price,
    editable,
    const DeepCollectionEquality().hash(_products),
  );

  /// Create a copy of ComboModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ComboModelImplCopyWith<_$ComboModelImpl> get copyWith =>
      __$$ComboModelImplCopyWithImpl<_$ComboModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComboModelImplToJson(this);
  }
}

abstract class _ComboModel implements ComboModel {
  const factory _ComboModel({
    required final String id,
    required final String name,
    required final String description,
    required final double price,
    required final bool editable,
    final List<ComboProduct> products,
  }) = _$ComboModelImpl;

  factory _ComboModel.fromJson(Map<String, dynamic> json) =
      _$ComboModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  double get price;
  @override
  bool get editable;
  @override
  List<ComboProduct> get products;

  /// Create a copy of ComboModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ComboModelImplCopyWith<_$ComboModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ComboProduct _$ComboProductFromJson(Map<String, dynamic> json) {
  return _ComboProduct.fromJson(json);
}

/// @nodoc
mixin _$ComboProduct {
  String get comboId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  ProductModel? get product => throw _privateConstructorUsedError;

  /// Serializes this ComboProduct to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ComboProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ComboProductCopyWith<ComboProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComboProductCopyWith<$Res> {
  factory $ComboProductCopyWith(
    ComboProduct value,
    $Res Function(ComboProduct) then,
  ) = _$ComboProductCopyWithImpl<$Res, ComboProduct>;
  @useResult
  $Res call({
    String comboId,
    String productId,
    int quantity,
    ProductModel? product,
  });

  $ProductModelCopyWith<$Res>? get product;
}

/// @nodoc
class _$ComboProductCopyWithImpl<$Res, $Val extends ComboProduct>
    implements $ComboProductCopyWith<$Res> {
  _$ComboProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ComboProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comboId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? product = freezed,
  }) {
    return _then(
      _value.copyWith(
            comboId: null == comboId
                ? _value.comboId
                : comboId // ignore: cast_nullable_to_non_nullable
                      as String,
            productId: null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            product: freezed == product
                ? _value.product
                : product // ignore: cast_nullable_to_non_nullable
                      as ProductModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of ComboProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductModelCopyWith<$Res>? get product {
    if (_value.product == null) {
      return null;
    }

    return $ProductModelCopyWith<$Res>(_value.product!, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ComboProductImplCopyWith<$Res>
    implements $ComboProductCopyWith<$Res> {
  factory _$$ComboProductImplCopyWith(
    _$ComboProductImpl value,
    $Res Function(_$ComboProductImpl) then,
  ) = __$$ComboProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String comboId,
    String productId,
    int quantity,
    ProductModel? product,
  });

  @override
  $ProductModelCopyWith<$Res>? get product;
}

/// @nodoc
class __$$ComboProductImplCopyWithImpl<$Res>
    extends _$ComboProductCopyWithImpl<$Res, _$ComboProductImpl>
    implements _$$ComboProductImplCopyWith<$Res> {
  __$$ComboProductImplCopyWithImpl(
    _$ComboProductImpl _value,
    $Res Function(_$ComboProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ComboProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comboId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? product = freezed,
  }) {
    return _then(
      _$ComboProductImpl(
        comboId: null == comboId
            ? _value.comboId
            : comboId // ignore: cast_nullable_to_non_nullable
                  as String,
        productId: null == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        product: freezed == product
            ? _value.product
            : product // ignore: cast_nullable_to_non_nullable
                  as ProductModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ComboProductImpl implements _ComboProduct {
  const _$ComboProductImpl({
    required this.comboId,
    required this.productId,
    required this.quantity,
    this.product,
  });

  factory _$ComboProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComboProductImplFromJson(json);

  @override
  final String comboId;
  @override
  final String productId;
  @override
  final int quantity;
  @override
  final ProductModel? product;

  @override
  String toString() {
    return 'ComboProduct(comboId: $comboId, productId: $productId, quantity: $quantity, product: $product)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComboProductImpl &&
            (identical(other.comboId, comboId) || other.comboId == comboId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, comboId, productId, quantity, product);

  /// Create a copy of ComboProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ComboProductImplCopyWith<_$ComboProductImpl> get copyWith =>
      __$$ComboProductImplCopyWithImpl<_$ComboProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComboProductImplToJson(this);
  }
}

abstract class _ComboProduct implements ComboProduct {
  const factory _ComboProduct({
    required final String comboId,
    required final String productId,
    required final int quantity,
    final ProductModel? product,
  }) = _$ComboProductImpl;

  factory _ComboProduct.fromJson(Map<String, dynamic> json) =
      _$ComboProductImpl.fromJson;

  @override
  String get comboId;
  @override
  String get productId;
  @override
  int get quantity;
  @override
  ProductModel? get product;

  /// Create a copy of ComboProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ComboProductImplCopyWith<_$ComboProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
