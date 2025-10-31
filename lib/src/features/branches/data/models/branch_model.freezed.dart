// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'branch_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BranchModel _$BranchModelFromJson(Map<String, dynamic> json) {
  return _BranchModel.fromJson(json);
}

/// @nodoc
mixin _$BranchModel {
  @JsonKey(readValue: _readId)
  String get id => throw _privateConstructorUsedError;
  @JsonKey(readValue: _readName)
  String get name => throw _privateConstructorUsedError;
  @JsonKey(readValue: _readAddress)
  String get address => throw _privateConstructorUsedError;
  @JsonKey(readValue: _readPhone)
  String get phone => throw _privateConstructorUsedError;

  /// Serializes this BranchModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BranchModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BranchModelCopyWith<BranchModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BranchModelCopyWith<$Res> {
  factory $BranchModelCopyWith(
    BranchModel value,
    $Res Function(BranchModel) then,
  ) = _$BranchModelCopyWithImpl<$Res, BranchModel>;
  @useResult
  $Res call({
    @JsonKey(readValue: _readId) String id,
    @JsonKey(readValue: _readName) String name,
    @JsonKey(readValue: _readAddress) String address,
    @JsonKey(readValue: _readPhone) String phone,
  });
}

/// @nodoc
class _$BranchModelCopyWithImpl<$Res, $Val extends BranchModel>
    implements $BranchModelCopyWith<$Res> {
  _$BranchModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BranchModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? phone = null,
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
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BranchModelImplCopyWith<$Res>
    implements $BranchModelCopyWith<$Res> {
  factory _$$BranchModelImplCopyWith(
    _$BranchModelImpl value,
    $Res Function(_$BranchModelImpl) then,
  ) = __$$BranchModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(readValue: _readId) String id,
    @JsonKey(readValue: _readName) String name,
    @JsonKey(readValue: _readAddress) String address,
    @JsonKey(readValue: _readPhone) String phone,
  });
}

/// @nodoc
class __$$BranchModelImplCopyWithImpl<$Res>
    extends _$BranchModelCopyWithImpl<$Res, _$BranchModelImpl>
    implements _$$BranchModelImplCopyWith<$Res> {
  __$$BranchModelImplCopyWithImpl(
    _$BranchModelImpl _value,
    $Res Function(_$BranchModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BranchModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? phone = null,
  }) {
    return _then(
      _$BranchModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BranchModelImpl implements _BranchModel {
  const _$BranchModelImpl({
    @JsonKey(readValue: _readId) required this.id,
    @JsonKey(readValue: _readName) required this.name,
    @JsonKey(readValue: _readAddress) required this.address,
    @JsonKey(readValue: _readPhone) required this.phone,
  });

  factory _$BranchModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BranchModelImplFromJson(json);

  @override
  @JsonKey(readValue: _readId)
  final String id;
  @override
  @JsonKey(readValue: _readName)
  final String name;
  @override
  @JsonKey(readValue: _readAddress)
  final String address;
  @override
  @JsonKey(readValue: _readPhone)
  final String phone;

  @override
  String toString() {
    return 'BranchModel(id: $id, name: $name, address: $address, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BranchModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, address, phone);

  /// Create a copy of BranchModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BranchModelImplCopyWith<_$BranchModelImpl> get copyWith =>
      __$$BranchModelImplCopyWithImpl<_$BranchModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BranchModelImplToJson(this);
  }
}

abstract class _BranchModel implements BranchModel {
  const factory _BranchModel({
    @JsonKey(readValue: _readId) required final String id,
    @JsonKey(readValue: _readName) required final String name,
    @JsonKey(readValue: _readAddress) required final String address,
    @JsonKey(readValue: _readPhone) required final String phone,
  }) = _$BranchModelImpl;

  factory _BranchModel.fromJson(Map<String, dynamic> json) =
      _$BranchModelImpl.fromJson;

  @override
  @JsonKey(readValue: _readId)
  String get id;
  @override
  @JsonKey(readValue: _readName)
  String get name;
  @override
  @JsonKey(readValue: _readAddress)
  String get address;
  @override
  @JsonKey(readValue: _readPhone)
  String get phone;

  /// Create a copy of BranchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BranchModelImplCopyWith<_$BranchModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
