// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SaleRequest {
  String get userId => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  List<SaleItemRequest> get items => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;

  /// Create a copy of SaleRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleRequestCopyWith<SaleRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleRequestCopyWith<$Res> {
  factory $SaleRequestCopyWith(
    SaleRequest value,
    $Res Function(SaleRequest) then,
  ) = _$SaleRequestCopyWithImpl<$Res, SaleRequest>;
  @useResult
  $Res call({
    String userId,
    double total,
    List<SaleItemRequest> items,
    DateTime? date,
  });
}

/// @nodoc
class _$SaleRequestCopyWithImpl<$Res, $Val extends SaleRequest>
    implements $SaleRequestCopyWith<$Res> {
  _$SaleRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? total = null,
    Object? items = null,
    Object? date = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as double,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<SaleItemRequest>,
            date: freezed == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SaleRequestImplCopyWith<$Res>
    implements $SaleRequestCopyWith<$Res> {
  factory _$$SaleRequestImplCopyWith(
    _$SaleRequestImpl value,
    $Res Function(_$SaleRequestImpl) then,
  ) = __$$SaleRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    double total,
    List<SaleItemRequest> items,
    DateTime? date,
  });
}

/// @nodoc
class __$$SaleRequestImplCopyWithImpl<$Res>
    extends _$SaleRequestCopyWithImpl<$Res, _$SaleRequestImpl>
    implements _$$SaleRequestImplCopyWith<$Res> {
  __$$SaleRequestImplCopyWithImpl(
    _$SaleRequestImpl _value,
    $Res Function(_$SaleRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SaleRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? total = null,
    Object? items = null,
    Object? date = freezed,
  }) {
    return _then(
      _$SaleRequestImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as double,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<SaleItemRequest>,
        date: freezed == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$SaleRequestImpl extends _SaleRequest {
  const _$SaleRequestImpl({
    required this.userId,
    required this.total,
    final List<SaleItemRequest> items = const [],
    this.date,
  }) : _items = items,
       super._();

  @override
  final String userId;
  @override
  final double total;
  final List<SaleItemRequest> _items;
  @override
  @JsonKey()
  List<SaleItemRequest> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final DateTime? date;

  @override
  String toString() {
    return 'SaleRequest(userId: $userId, total: $total, items: $items, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleRequestImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    total,
    const DeepCollectionEquality().hash(_items),
    date,
  );

  /// Create a copy of SaleRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleRequestImplCopyWith<_$SaleRequestImpl> get copyWith =>
      __$$SaleRequestImplCopyWithImpl<_$SaleRequestImpl>(this, _$identity);
}

abstract class _SaleRequest extends SaleRequest {
  const factory _SaleRequest({
    required final String userId,
    required final double total,
    final List<SaleItemRequest> items,
    final DateTime? date,
  }) = _$SaleRequestImpl;
  const _SaleRequest._() : super._();

  @override
  String get userId;
  @override
  double get total;
  @override
  List<SaleItemRequest> get items;
  @override
  DateTime? get date;

  /// Create a copy of SaleRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleRequestImplCopyWith<_$SaleRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SaleItemRequest {
  String get productId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get unitPrice => throw _privateConstructorUsedError;

  /// Create a copy of SaleItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleItemRequestCopyWith<SaleItemRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleItemRequestCopyWith<$Res> {
  factory $SaleItemRequestCopyWith(
    SaleItemRequest value,
    $Res Function(SaleItemRequest) then,
  ) = _$SaleItemRequestCopyWithImpl<$Res, SaleItemRequest>;
  @useResult
  $Res call({String productId, int quantity, double unitPrice});
}

/// @nodoc
class _$SaleItemRequestCopyWithImpl<$Res, $Val extends SaleItemRequest>
    implements $SaleItemRequestCopyWith<$Res> {
  _$SaleItemRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleItemRequest
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
abstract class _$$SaleItemRequestImplCopyWith<$Res>
    implements $SaleItemRequestCopyWith<$Res> {
  factory _$$SaleItemRequestImplCopyWith(
    _$SaleItemRequestImpl value,
    $Res Function(_$SaleItemRequestImpl) then,
  ) = __$$SaleItemRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String productId, int quantity, double unitPrice});
}

/// @nodoc
class __$$SaleItemRequestImplCopyWithImpl<$Res>
    extends _$SaleItemRequestCopyWithImpl<$Res, _$SaleItemRequestImpl>
    implements _$$SaleItemRequestImplCopyWith<$Res> {
  __$$SaleItemRequestImplCopyWithImpl(
    _$SaleItemRequestImpl _value,
    $Res Function(_$SaleItemRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SaleItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? quantity = null,
    Object? unitPrice = null,
  }) {
    return _then(
      _$SaleItemRequestImpl(
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

class _$SaleItemRequestImpl extends _SaleItemRequest {
  const _$SaleItemRequestImpl({
    required this.productId,
    required this.quantity,
    required this.unitPrice,
  }) : super._();

  @override
  final String productId;
  @override
  final int quantity;
  @override
  final double unitPrice;

  @override
  String toString() {
    return 'SaleItemRequest(productId: $productId, quantity: $quantity, unitPrice: $unitPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleItemRequestImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice));
  }

  @override
  int get hashCode => Object.hash(runtimeType, productId, quantity, unitPrice);

  /// Create a copy of SaleItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleItemRequestImplCopyWith<_$SaleItemRequestImpl> get copyWith =>
      __$$SaleItemRequestImplCopyWithImpl<_$SaleItemRequestImpl>(
        this,
        _$identity,
      );
}

abstract class _SaleItemRequest extends SaleItemRequest {
  const factory _SaleItemRequest({
    required final String productId,
    required final int quantity,
    required final double unitPrice,
  }) = _$SaleItemRequestImpl;
  const _SaleItemRequest._() : super._();

  @override
  String get productId;
  @override
  int get quantity;
  @override
  double get unitPrice;

  /// Create a copy of SaleItemRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleItemRequestImplCopyWith<_$SaleItemRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
