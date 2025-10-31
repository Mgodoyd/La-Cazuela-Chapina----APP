// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_movement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

InventoryMovementModel _$InventoryMovementModelFromJson(
  Map<String, dynamic> json,
) {
  return _InventoryMovementModel.fromJson(json);
}

/// @nodoc
mixin _$InventoryMovementModel {
  String get type => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  double? get cost => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;

  /// Serializes this InventoryMovementModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InventoryMovementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventoryMovementModelCopyWith<InventoryMovementModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryMovementModelCopyWith<$Res> {
  factory $InventoryMovementModelCopyWith(
    InventoryMovementModel value,
    $Res Function(InventoryMovementModel) then,
  ) = _$InventoryMovementModelCopyWithImpl<$Res, InventoryMovementModel>;
  @useResult
  $Res call({String type, double quantity, double? cost, String? reason});
}

/// @nodoc
class _$InventoryMovementModelCopyWithImpl<
  $Res,
  $Val extends InventoryMovementModel
>
    implements $InventoryMovementModelCopyWith<$Res> {
  _$InventoryMovementModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InventoryMovementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? quantity = null,
    Object? cost = freezed,
    Object? reason = freezed,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as double,
            cost: freezed == cost
                ? _value.cost
                : cost // ignore: cast_nullable_to_non_nullable
                      as double?,
            reason: freezed == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InventoryMovementModelImplCopyWith<$Res>
    implements $InventoryMovementModelCopyWith<$Res> {
  factory _$$InventoryMovementModelImplCopyWith(
    _$InventoryMovementModelImpl value,
    $Res Function(_$InventoryMovementModelImpl) then,
  ) = __$$InventoryMovementModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, double quantity, double? cost, String? reason});
}

/// @nodoc
class __$$InventoryMovementModelImplCopyWithImpl<$Res>
    extends
        _$InventoryMovementModelCopyWithImpl<$Res, _$InventoryMovementModelImpl>
    implements _$$InventoryMovementModelImplCopyWith<$Res> {
  __$$InventoryMovementModelImplCopyWithImpl(
    _$InventoryMovementModelImpl _value,
    $Res Function(_$InventoryMovementModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InventoryMovementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? quantity = null,
    Object? cost = freezed,
    Object? reason = freezed,
  }) {
    return _then(
      _$InventoryMovementModelImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as double,
        cost: freezed == cost
            ? _value.cost
            : cost // ignore: cast_nullable_to_non_nullable
                  as double?,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryMovementModelImpl implements _InventoryMovementModel {
  const _$InventoryMovementModelImpl({
    required this.type,
    required this.quantity,
    this.cost,
    this.reason,
  });

  factory _$InventoryMovementModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryMovementModelImplFromJson(json);

  @override
  final String type;
  @override
  final double quantity;
  @override
  final double? cost;
  @override
  final String? reason;

  @override
  String toString() {
    return 'InventoryMovementModel(type: $type, quantity: $quantity, cost: $cost, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryMovementModelImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, quantity, cost, reason);

  /// Create a copy of InventoryMovementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryMovementModelImplCopyWith<_$InventoryMovementModelImpl>
  get copyWith =>
      __$$InventoryMovementModelImplCopyWithImpl<_$InventoryMovementModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryMovementModelImplToJson(this);
  }
}

abstract class _InventoryMovementModel implements InventoryMovementModel {
  const factory _InventoryMovementModel({
    required final String type,
    required final double quantity,
    final double? cost,
    final String? reason,
  }) = _$InventoryMovementModelImpl;

  factory _InventoryMovementModel.fromJson(Map<String, dynamic> json) =
      _$InventoryMovementModelImpl.fromJson;

  @override
  String get type;
  @override
  double get quantity;
  @override
  double? get cost;
  @override
  String? get reason;

  /// Create a copy of InventoryMovementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventoryMovementModelImplCopyWith<_$InventoryMovementModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
