part of 'sale_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SaleModel _$SaleModelFromJson(Map<String, dynamic> json) {
  return _SaleModel.fromJson(json);
}

/// @nodoc
mixin _$SaleModel {
  String get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  UserModel? get user => throw _privateConstructorUsedError;
  List<SaleItemModel> get items => throw _privateConstructorUsedError;

 
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleModelCopyWith<SaleModel> get copyWith =>
      throw _privateConstructorUsedError;
}


abstract class $SaleModelCopyWith<$Res> {
  factory $SaleModelCopyWith(SaleModel value, $Res Function(SaleModel) then) =
      _$SaleModelCopyWithImpl<$Res, SaleModel>;
  @useResult
  $Res call({
    String id,
    DateTime date,
    String userId,
    double total,
    UserModel? user,
    List<SaleItemModel> items,
  });

  $UserModelCopyWith<$Res>? get user;
}


class _$SaleModelCopyWithImpl<$Res, $Val extends SaleModel>
    implements $SaleModelCopyWith<$Res> {
  _$SaleModelCopyWithImpl(this._value, this._then);

    
  final $Val _value;

  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id,
    Object? date,
    Object? userId,
    Object? total,
    Object? user = freezed,
    Object? items,
  }) {
    return _then(
      _value.copyWith(
            id: id 
                      as String,
            date: date 
                      as DateTime,
            userId: userId 
                      as String,
            total: total 
                      as double,
            user: user 
                      as UserModel?,
            items: items 
                      as List<SaleItemModel>,
          )
          as $Val,
    );
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

abstract class _$$SaleModelImplCopyWith<$Res>
    implements $SaleModelCopyWith<$Res> {
  factory _$$SaleModelImplCopyWith(
    _$SaleModelImpl value,
    $Res Function(_$SaleModelImpl) then,
  ) = __$$SaleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    DateTime date,
    String userId,
    double total,
    UserModel? user,
    List<SaleItemModel> items,
  });

  @override
  $UserModelCopyWith<$Res>? get user;
}

class __$$SaleModelImplCopyWithImpl<$Res>
    extends _$SaleModelCopyWithImpl<$Res, _$SaleModelImpl>
    implements _$$SaleModelImplCopyWith<$Res> {
  __$$SaleModelImplCopyWithImpl(
    _$SaleModelImpl _value,
    $Res Function(_$SaleModelImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? userId = null,
    Object? total = null,
    Object? user = freezed,
    Object? items = null,
  }) {
    return _then(
      _$SaleModelImpl(
        id: null == id
            ? _value.id
            : id 
                  as String,
        date: null == date
            ? _value.date
            : date 
                  as DateTime,
        userId: null == userId
            ? _value.userId
            : userId 
                  as String,
        total: null == total
            ? _value.total
            : total 
                  as double,
        user: freezed == user
            ? _value.user
            : user 
                  as UserModel?,
        items: null == items
            ? _value._items
            : items 
                  as List<SaleItemModel>,
      ),
    );
  }
}

@JsonSerializable()
class _$SaleModelImpl implements _SaleModel {
  const _$SaleModelImpl({
    required this.id,
    required this.date,
    required this.userId,
    required this.total,
    this.user,
    final List<SaleItemModel> items = const [],
  }) : _items = items;

  factory _$SaleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleModelImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime date;
  @override
  final String userId;
  @override
  final double total;
  @override
  final UserModel? user;
  final List<SaleItemModel> _items;
  @override
  @JsonKey()
  List<SaleItemModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'SaleModel(id: $id, date: $date, userId: $userId, total: $total, user: $user, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.user, user) || other.user == user) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    date,
    userId,
    total,
    user,
    const DeepCollectionEquality().hash(_items),
  );

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleModelImplCopyWith<_$SaleModelImpl> get copyWith =>
      __$$SaleModelImplCopyWithImpl<_$SaleModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleModelImplToJson(this);
  }
}

abstract class _SaleModel implements SaleModel {
  const factory _SaleModel({
    required final String id,
    required final DateTime date,
    required final String userId,
    required final double total,
    final UserModel? user,
    final List<SaleItemModel> items,
  }) = _$SaleModelImpl;

  factory _SaleModel.fromJson(Map<String, dynamic> json) =
      _$SaleModelImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get date;
  @override
  String get userId;
  @override
  double get total;
  @override
  UserModel? get user;
  @override
  List<SaleItemModel> get items;

  /// Create a copy of SaleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleModelImplCopyWith<_$SaleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SaleItemModel _$SaleItemModelFromJson(Map<String, dynamic> json) {
  return _SaleItemModel.fromJson(json);
}

mixin _$SaleItemModel {
  String get productId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get unitPrice => throw _privateConstructorUsedError;
  ProductModel? get product => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleItemModelCopyWith<SaleItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

abstract class $SaleItemModelCopyWith<$Res> {
  factory $SaleItemModelCopyWith(
    SaleItemModel value,
    $Res Function(SaleItemModel) then,
  ) = _$SaleItemModelCopyWithImpl<$Res, SaleItemModel>;
  @useResult
  $Res call({
    String productId,
    int quantity,
    double unitPrice,
    ProductModel? product,
  });

  $ProductModelCopyWith<$Res>? get product;
}

/// @nodoc
class _$SaleItemModelCopyWithImpl<$Res, $Val extends SaleItemModel>
    implements $SaleItemModelCopyWith<$Res> {
  _$SaleItemModelCopyWithImpl(this._value, this._then);

    
  final $Val _value;
    
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? product = freezed,
  }) {
    return _then(
      _value.copyWith(
            productId: null == productId
                ? _value.productId
                : productId 
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity 
                      as int,
            unitPrice: null == unitPrice
                ? _value.unitPrice
                : unitPrice 
                      as double,
            product: freezed == product
                ? _value.product
                : product 
                      as ProductModel?,
          )
          as $Val,
    );
  }

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
abstract class _$$SaleItemModelImplCopyWith<$Res>
    implements $SaleItemModelCopyWith<$Res> {
  factory _$$SaleItemModelImplCopyWith(
    _$SaleItemModelImpl value,
    $Res Function(_$SaleItemModelImpl) then,
  ) = __$$SaleItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String productId,
    int quantity,
    double unitPrice,
    ProductModel? product,
  });

  @override
  $ProductModelCopyWith<$Res>? get product;
}

class __$$SaleItemModelImplCopyWithImpl<$Res>
    extends _$SaleItemModelCopyWithImpl<$Res, _$SaleItemModelImpl>
    implements _$$SaleItemModelImplCopyWith<$Res> {
  __$$SaleItemModelImplCopyWithImpl(
    _$SaleItemModelImpl _value,
    $Res Function(_$SaleItemModelImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? product = freezed,
  }) {
    return _then(
      _$SaleItemModelImpl(
        productId: null == productId
            ? _value.productId
            : productId 
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity 
                  as int,
        unitPrice: null == unitPrice
            ? _value.unitPrice
            : unitPrice 
                  as double,
        product: freezed == product
            ? _value.product
            : product 
                  as ProductModel?,
      ),
    );
  }
}

@JsonSerializable()
class _$SaleItemModelImpl implements _SaleItemModel {
  const _$SaleItemModelImpl({
    required this.productId,
    required this.quantity,
    required this.unitPrice,
    this.product,
  });

  factory _$SaleItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleItemModelImplFromJson(json);

  @override
  final String productId;
  @override
  final int quantity;
  @override
  final double unitPrice;
  @override
  final ProductModel? product;

  @override
  String toString() {
    return 'SaleItemModel(productId: $productId, quantity: $quantity, unitPrice: $unitPrice, product: $product)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleItemModelImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, productId, quantity, unitPrice, product);

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleItemModelImplCopyWith<_$SaleItemModelImpl> get copyWith =>
      __$$SaleItemModelImplCopyWithImpl<_$SaleItemModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleItemModelImplToJson(this);
  }
}

abstract class _SaleItemModel implements SaleItemModel {
  const factory _SaleItemModel({
    required final String productId,
    required final int quantity,
    required final double unitPrice,
    final ProductModel? product,
  }) = _$SaleItemModelImpl;

  factory _SaleItemModel.fromJson(Map<String, dynamic> json) =
      _$SaleItemModelImpl.fromJson;

  @override
  String get productId;
  @override
  int get quantity;
  @override
  double get unitPrice;
  @override
  ProductModel? get product;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleItemModelImplCopyWith<_$SaleItemModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
