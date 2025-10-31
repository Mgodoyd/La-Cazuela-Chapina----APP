// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'raw_material_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RawMaterialModel _$RawMaterialModelFromJson(Map<String, dynamic> json) {
  return _RawMaterialModel.fromJson(json);
}

/// @nodoc
mixin _$RawMaterialModel {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  double get minStock => throw _privateConstructorUsedError;

  /// Serializes this RawMaterialModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RawMaterialModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RawMaterialModelCopyWith<RawMaterialModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RawMaterialModelCopyWith<$Res> {
  factory $RawMaterialModelCopyWith(
    RawMaterialModel value,
    $Res Function(RawMaterialModel) then,
  ) = _$RawMaterialModelCopyWithImpl<$Res, RawMaterialModel>;
  @useResult
  $Res call({String? id, String name, String unit, double minStock});
}

/// @nodoc
class _$RawMaterialModelCopyWithImpl<$Res, $Val extends RawMaterialModel>
    implements $RawMaterialModelCopyWith<$Res> {
  _$RawMaterialModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RawMaterialModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? unit = null,
    Object? minStock = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            unit: null == unit
                ? _value.unit
                : unit // ignore: cast_nullable_to_non_nullable
                      as String,
            minStock: null == minStock
                ? _value.minStock
                : minStock // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RawMaterialModelImplCopyWith<$Res>
    implements $RawMaterialModelCopyWith<$Res> {
  factory _$$RawMaterialModelImplCopyWith(
    _$RawMaterialModelImpl value,
    $Res Function(_$RawMaterialModelImpl) then,
  ) = __$$RawMaterialModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String name, String unit, double minStock});
}

/// @nodoc
class __$$RawMaterialModelImplCopyWithImpl<$Res>
    extends _$RawMaterialModelCopyWithImpl<$Res, _$RawMaterialModelImpl>
    implements _$$RawMaterialModelImplCopyWith<$Res> {
  __$$RawMaterialModelImplCopyWithImpl(
    _$RawMaterialModelImpl _value,
    $Res Function(_$RawMaterialModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RawMaterialModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? unit = null,
    Object? minStock = null,
  }) {
    return _then(
      _$RawMaterialModelImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        unit: null == unit
            ? _value.unit
            : unit // ignore: cast_nullable_to_non_nullable
                  as String,
        minStock: null == minStock
            ? _value.minStock
            : minStock // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RawMaterialModelImpl implements _RawMaterialModel {
  const _$RawMaterialModelImpl({
    this.id,
    required this.name,
    required this.unit,
    required this.minStock,
  });

  factory _$RawMaterialModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RawMaterialModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final String unit;
  @override
  final double minStock;

  @override
  String toString() {
    return 'RawMaterialModel(id: $id, name: $name, unit: $unit, minStock: $minStock)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RawMaterialModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.minStock, minStock) ||
                other.minStock == minStock));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, unit, minStock);

  /// Create a copy of RawMaterialModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RawMaterialModelImplCopyWith<_$RawMaterialModelImpl> get copyWith =>
      __$$RawMaterialModelImplCopyWithImpl<_$RawMaterialModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RawMaterialModelImplToJson(this);
  }
}

abstract class _RawMaterialModel implements RawMaterialModel {
  const factory _RawMaterialModel({
    final String? id,
    required final String name,
    required final String unit,
    required final double minStock,
  }) = _$RawMaterialModelImpl;

  factory _RawMaterialModel.fromJson(Map<String, dynamic> json) =
      _$RawMaterialModelImpl.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  String get unit;
  @override
  double get minStock;

  /// Create a copy of RawMaterialModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RawMaterialModelImplCopyWith<_$RawMaterialModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
