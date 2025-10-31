// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OrderRequest _$OrderRequestFromJson(Map<String, dynamic> json) {
  return _OrderRequest.fromJson(json);
}

/// @nodoc
mixin _$OrderRequest {
  @JsonKey(name: 'UserId')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'Status')
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'Confirmed')
  bool get confirmed => throw _privateConstructorUsedError;
  @JsonKey(name: 'Stock')
  int get stock => throw _privateConstructorUsedError;
  @JsonKey(name: 'Items')
  List<OrderItemRequest> get items => throw _privateConstructorUsedError;
  @JsonKey(name: 'CreatedAt')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this OrderRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderRequestCopyWith<OrderRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderRequestCopyWith<$Res> {
  factory $OrderRequestCopyWith(
    OrderRequest value,
    $Res Function(OrderRequest) then,
  ) = _$OrderRequestCopyWithImpl<$Res, OrderRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'UserId') String userId,
    @JsonKey(name: 'Status') String status,
    @JsonKey(name: 'Confirmed') bool confirmed,
    @JsonKey(name: 'Stock') int stock,
    @JsonKey(name: 'Items') List<OrderItemRequest> items,
    @JsonKey(name: 'CreatedAt') DateTime? createdAt,
  });
}

/// @nodoc
class _$OrderRequestCopyWithImpl<$Res, $Val extends OrderRequest>
    implements $OrderRequestCopyWith<$Res> {
  _$OrderRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? status = null,
    Object? confirmed = null,
    Object? stock = null,
    Object? items = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            confirmed: null == confirmed
                ? _value.confirmed
                : confirmed // ignore: cast_nullable_to_non_nullable
                      as bool,
            stock: null == stock
                ? _value.stock
                : stock // ignore: cast_nullable_to_non_nullable
                      as int,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<OrderItemRequest>,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderRequestImplCopyWith<$Res>
    implements $OrderRequestCopyWith<$Res> {
  factory _$$OrderRequestImplCopyWith(
    _$OrderRequestImpl value,
    $Res Function(_$OrderRequestImpl) then,
  ) = __$$OrderRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'UserId') String userId,
    @JsonKey(name: 'Status') String status,
    @JsonKey(name: 'Confirmed') bool confirmed,
    @JsonKey(name: 'Stock') int stock,
    @JsonKey(name: 'Items') List<OrderItemRequest> items,
    @JsonKey(name: 'CreatedAt') DateTime? createdAt,
  });
}

/// @nodoc
class __$$OrderRequestImplCopyWithImpl<$Res>
    extends _$OrderRequestCopyWithImpl<$Res, _$OrderRequestImpl>
    implements _$$OrderRequestImplCopyWith<$Res> {
  __$$OrderRequestImplCopyWithImpl(
    _$OrderRequestImpl _value,
    $Res Function(_$OrderRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? status = null,
    Object? confirmed = null,
    Object? stock = null,
    Object? items = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$OrderRequestImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        confirmed: null == confirmed
            ? _value.confirmed
            : confirmed // ignore: cast_nullable_to_non_nullable
                  as bool,
        stock: null == stock
            ? _value.stock
            : stock // ignore: cast_nullable_to_non_nullable
                  as int,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<OrderItemRequest>,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderRequestImpl implements _OrderRequest {
  const _$OrderRequestImpl({
    @JsonKey(name: 'UserId') required this.userId,
    @JsonKey(name: 'Status') required this.status,
    @JsonKey(name: 'Confirmed') required this.confirmed,
    @JsonKey(name: 'Stock') required this.stock,
    @JsonKey(name: 'Items') final List<OrderItemRequest> items = const [],
    @JsonKey(name: 'CreatedAt') this.createdAt,
  }) : _items = items;

  factory _$OrderRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderRequestImplFromJson(json);

  @override
  @JsonKey(name: 'UserId')
  final String userId;
  @override
  @JsonKey(name: 'Status')
  final String status;
  @override
  @JsonKey(name: 'Confirmed')
  final bool confirmed;
  @override
  @JsonKey(name: 'Stock')
  final int stock;
  final List<OrderItemRequest> _items;
  @override
  @JsonKey(name: 'Items')
  List<OrderItemRequest> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey(name: 'CreatedAt')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'OrderRequest(userId: $userId, status: $status, confirmed: $confirmed, stock: $stock, items: $items, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderRequestImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.confirmed, confirmed) ||
                other.confirmed == confirmed) &&
            (identical(other.stock, stock) || other.stock == stock) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    status,
    confirmed,
    stock,
    const DeepCollectionEquality().hash(_items),
    createdAt,
  );

  /// Create a copy of OrderRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderRequestImplCopyWith<_$OrderRequestImpl> get copyWith =>
      __$$OrderRequestImplCopyWithImpl<_$OrderRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderRequestImplToJson(this);
  }
}

abstract class _OrderRequest implements OrderRequest {
  const factory _OrderRequest({
    @JsonKey(name: 'UserId') required final String userId,
    @JsonKey(name: 'Status') required final String status,
    @JsonKey(name: 'Confirmed') required final bool confirmed,
    @JsonKey(name: 'Stock') required final int stock,
    @JsonKey(name: 'Items') final List<OrderItemRequest> items,
    @JsonKey(name: 'CreatedAt') final DateTime? createdAt,
  }) = _$OrderRequestImpl;

  factory _OrderRequest.fromJson(Map<String, dynamic> json) =
      _$OrderRequestImpl.fromJson;

  @override
  @JsonKey(name: 'UserId')
  String get userId;
  @override
  @JsonKey(name: 'Status')
  String get status;
  @override
  @JsonKey(name: 'Confirmed')
  bool get confirmed;
  @override
  @JsonKey(name: 'Stock')
  int get stock;
  @override
  @JsonKey(name: 'Items')
  List<OrderItemRequest> get items;
  @override
  @JsonKey(name: 'CreatedAt')
  DateTime? get createdAt;

  /// Create a copy of OrderRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderRequestImplCopyWith<_$OrderRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderItemRequest _$OrderItemRequestFromJson(Map<String, dynamic> json) {
  return _OrderItemRequest.fromJson(json);
}

/// @nodoc
mixin _$OrderItemRequest {
  @JsonKey(name: 'ProductId')
  String get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'Quantity')
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'UnitPrice')
  double get unitPrice => throw _privateConstructorUsedError;

  /// Serializes this OrderItemRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderItemRequestCopyWith<OrderItemRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderItemRequestCopyWith<$Res> {
  factory $OrderItemRequestCopyWith(
    OrderItemRequest value,
    $Res Function(OrderItemRequest) then,
  ) = _$OrderItemRequestCopyWithImpl<$Res, OrderItemRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'ProductId') String productId,
    @JsonKey(name: 'Quantity') int quantity,
    @JsonKey(name: 'UnitPrice') double unitPrice,
  });
}

/// @nodoc
class _$OrderItemRequestCopyWithImpl<$Res, $Val extends OrderItemRequest>
    implements $OrderItemRequestCopyWith<$Res> {
  _$OrderItemRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? quantity = null,
    Object? unitPrice = null,
  }) {
    return _then(
      _value.copyWith(
            productId: null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            unitPrice: null == unitPrice
                ? _value.unitPrice
                : unitPrice // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderItemRequestImplCopyWith<$Res>
    implements $OrderItemRequestCopyWith<$Res> {
  factory _$$OrderItemRequestImplCopyWith(
    _$OrderItemRequestImpl value,
    $Res Function(_$OrderItemRequestImpl) then,
  ) = __$$OrderItemRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'ProductId') String productId,
    @JsonKey(name: 'Quantity') int quantity,
    @JsonKey(name: 'UnitPrice') double unitPrice,
  });
}

/// @nodoc
class __$$OrderItemRequestImplCopyWithImpl<$Res>
    extends _$OrderItemRequestCopyWithImpl<$Res, _$OrderItemRequestImpl>
    implements _$$OrderItemRequestImplCopyWith<$Res> {
  __$$OrderItemRequestImplCopyWithImpl(
    _$OrderItemRequestImpl _value,
    $Res Function(_$OrderItemRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? quantity = null,
    Object? unitPrice = null,
  }) {
    return _then(
      _$OrderItemRequestImpl(
        productId: null == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        unitPrice: null == unitPrice
            ? _value.unitPrice
            : unitPrice // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderItemRequestImpl implements _OrderItemRequest {
  const _$OrderItemRequestImpl({
    @JsonKey(name: 'ProductId') required this.productId,
    @JsonKey(name: 'Quantity') required this.quantity,
    @JsonKey(name: 'UnitPrice') required this.unitPrice,
  });

  factory _$OrderItemRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderItemRequestImplFromJson(json);

  @override
  @JsonKey(name: 'ProductId')
  final String productId;
  @override
  @JsonKey(name: 'Quantity')
  final int quantity;
  @override
  @JsonKey(name: 'UnitPrice')
  final double unitPrice;

  @override
  String toString() {
    return 'OrderItemRequest(productId: $productId, quantity: $quantity, unitPrice: $unitPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderItemRequestImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, productId, quantity, unitPrice);

  /// Create a copy of OrderItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderItemRequestImplCopyWith<_$OrderItemRequestImpl> get copyWith =>
      __$$OrderItemRequestImplCopyWithImpl<_$OrderItemRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderItemRequestImplToJson(this);
  }
}

abstract class _OrderItemRequest implements OrderItemRequest {
  const factory _OrderItemRequest({
    @JsonKey(name: 'ProductId') required final String productId,
    @JsonKey(name: 'Quantity') required final int quantity,
    @JsonKey(name: 'UnitPrice') required final double unitPrice,
  }) = _$OrderItemRequestImpl;

  factory _OrderItemRequest.fromJson(Map<String, dynamic> json) =
      _$OrderItemRequestImpl.fromJson;

  @override
  @JsonKey(name: 'ProductId')
  String get productId;
  @override
  @JsonKey(name: 'Quantity')
  int get quantity;
  @override
  @JsonKey(name: 'UnitPrice')
  double get unitPrice;

  /// Create a copy of OrderItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderItemRequestImplCopyWith<_$OrderItemRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
