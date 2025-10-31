// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

InventoryItemModel _$InventoryItemModelFromJson(Map<String, dynamic> json) {
  return _InventoryItemModel.fromJson(json);
}

/// @nodoc
mixin _$InventoryItemModel {
  String? get id => throw _privateConstructorUsedError;
  RawMaterialModel get rawMaterial => throw _privateConstructorUsedError;
  double get currentQuantity => throw _privateConstructorUsedError;

  /// Serializes this InventoryItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InventoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventoryItemModelCopyWith<InventoryItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryItemModelCopyWith<$Res> {
  factory $InventoryItemModelCopyWith(
    InventoryItemModel value,
    $Res Function(InventoryItemModel) then,
  ) = _$InventoryItemModelCopyWithImpl<$Res, InventoryItemModel>;
  @useResult
  $Res call({String? id, RawMaterialModel rawMaterial, double currentQuantity});

  $RawMaterialModelCopyWith<$Res> get rawMaterial;
}

/// @nodoc
class _$InventoryItemModelCopyWithImpl<$Res, $Val extends InventoryItemModel>
    implements $InventoryItemModelCopyWith<$Res> {
  _$InventoryItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InventoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? rawMaterial = null,
    Object? currentQuantity = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            rawMaterial: null == rawMaterial
                ? _value.rawMaterial
                : rawMaterial // ignore: cast_nullable_to_non_nullable
                      as RawMaterialModel,
            currentQuantity: null == currentQuantity
                ? _value.currentQuantity
                : currentQuantity // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }

  /// Create a copy of InventoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RawMaterialModelCopyWith<$Res> get rawMaterial {
    return $RawMaterialModelCopyWith<$Res>(_value.rawMaterial, (value) {
      return _then(_value.copyWith(rawMaterial: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InventoryItemModelImplCopyWith<$Res>
    implements $InventoryItemModelCopyWith<$Res> {
  factory _$$InventoryItemModelImplCopyWith(
    _$InventoryItemModelImpl value,
    $Res Function(_$InventoryItemModelImpl) then,
  ) = __$$InventoryItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, RawMaterialModel rawMaterial, double currentQuantity});

  @override
  $RawMaterialModelCopyWith<$Res> get rawMaterial;
}

/// @nodoc
class __$$InventoryItemModelImplCopyWithImpl<$Res>
    extends _$InventoryItemModelCopyWithImpl<$Res, _$InventoryItemModelImpl>
    implements _$$InventoryItemModelImplCopyWith<$Res> {
  __$$InventoryItemModelImplCopyWithImpl(
    _$InventoryItemModelImpl _value,
    $Res Function(_$InventoryItemModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InventoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? rawMaterial = null,
    Object? currentQuantity = null,
  }) {
    return _then(
      _$InventoryItemModelImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        rawMaterial: null == rawMaterial
            ? _value.rawMaterial
            : rawMaterial // ignore: cast_nullable_to_non_nullable
                  as RawMaterialModel,
        currentQuantity: null == currentQuantity
            ? _value.currentQuantity
            : currentQuantity // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryItemModelImpl implements _InventoryItemModel {
  const _$InventoryItemModelImpl({
    this.id,
    required this.rawMaterial,
    required this.currentQuantity,
  });

  factory _$InventoryItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryItemModelImplFromJson(json);

  @override
  final String? id;
  @override
  final RawMaterialModel rawMaterial;
  @override
  final double currentQuantity;

  @override
  String toString() {
    return 'InventoryItemModel(id: $id, rawMaterial: $rawMaterial, currentQuantity: $currentQuantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryItemModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.rawMaterial, rawMaterial) ||
                other.rawMaterial == rawMaterial) &&
            (identical(other.currentQuantity, currentQuantity) ||
                other.currentQuantity == currentQuantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, rawMaterial, currentQuantity);

  /// Create a copy of InventoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryItemModelImplCopyWith<_$InventoryItemModelImpl> get copyWith =>
      __$$InventoryItemModelImplCopyWithImpl<_$InventoryItemModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryItemModelImplToJson(this);
  }
}

abstract class _InventoryItemModel implements InventoryItemModel {
  const factory _InventoryItemModel({
    final String? id,
    required final RawMaterialModel rawMaterial,
    required final double currentQuantity,
  }) = _$InventoryItemModelImpl;

  factory _InventoryItemModel.fromJson(Map<String, dynamic> json) =
      _$InventoryItemModelImpl.fromJson;

  @override
  String? get id;
  @override
  RawMaterialModel get rawMaterial;
  @override
  double get currentQuantity;

  /// Create a copy of InventoryItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventoryItemModelImplCopyWith<_$InventoryItemModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
