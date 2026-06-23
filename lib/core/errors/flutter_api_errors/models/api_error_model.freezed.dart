// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_error_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ApiErrorModel _$ApiErrorModelFromJson(Map<String, dynamic> json) {
  return _ApiErrorModel.fromJson(json);
}

/// @nodoc
mixin _$ApiErrorModel {
  /// هل العملية ناجحة؟ — دائماً false هنا
  bool get success => throw _privateConstructorUsedError;

  /// كود الخطأ من الـ Backend (مثلاً "USER_NOT_FOUND")
  String? get errorCode => throw _privateConstructorUsedError;

  /// رسالة تقنية من الـ Server (للـ Logging، لا للعرض المباشر)
  String? get message => throw _privateConstructorUsedError;

  /// أخطاء التحقق: Map من اسم الحقل → قائمة الأخطاء
  /// { "email": ["مستخدم مسبقاً"], "password": ["قصيرة جداً"] }
  Map<String, List<String>> get errors => throw _privateConstructorUsedError;

  /// طابع التوقيت للخطأ
  String? get timestamp => throw _privateConstructorUsedError;

  /// Serializes this ApiErrorModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiErrorModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiErrorModelCopyWith<ApiErrorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiErrorModelCopyWith<$Res> {
  factory $ApiErrorModelCopyWith(
    ApiErrorModel value,
    $Res Function(ApiErrorModel) then,
  ) = _$ApiErrorModelCopyWithImpl<$Res, ApiErrorModel>;
  @useResult
  $Res call({
    bool success,
    String? errorCode,
    String? message,
    Map<String, List<String>> errors,
    String? timestamp,
  });
}

/// @nodoc
class _$ApiErrorModelCopyWithImpl<$Res, $Val extends ApiErrorModel>
    implements $ApiErrorModelCopyWith<$Res> {
  _$ApiErrorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiErrorModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? errorCode = freezed,
    Object? message = freezed,
    Object? errors = null,
    Object? timestamp = freezed,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorCode: freezed == errorCode
                ? _value.errorCode
                : errorCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            errors: null == errors
                ? _value.errors
                : errors // ignore: cast_nullable_to_non_nullable
                      as Map<String, List<String>>,
            timestamp: freezed == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApiErrorModelImplCopyWith<$Res>
    implements $ApiErrorModelCopyWith<$Res> {
  factory _$$ApiErrorModelImplCopyWith(
    _$ApiErrorModelImpl value,
    $Res Function(_$ApiErrorModelImpl) then,
  ) = __$$ApiErrorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    String? errorCode,
    String? message,
    Map<String, List<String>> errors,
    String? timestamp,
  });
}

/// @nodoc
class __$$ApiErrorModelImplCopyWithImpl<$Res>
    extends _$ApiErrorModelCopyWithImpl<$Res, _$ApiErrorModelImpl>
    implements _$$ApiErrorModelImplCopyWith<$Res> {
  __$$ApiErrorModelImplCopyWithImpl(
    _$ApiErrorModelImpl _value,
    $Res Function(_$ApiErrorModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApiErrorModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? errorCode = freezed,
    Object? message = freezed,
    Object? errors = null,
    Object? timestamp = freezed,
  }) {
    return _then(
      _$ApiErrorModelImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorCode: freezed == errorCode
            ? _value.errorCode
            : errorCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        errors: null == errors
            ? _value._errors
            : errors // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<String>>,
        timestamp: freezed == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiErrorModelImpl implements _ApiErrorModel {
  const _$ApiErrorModelImpl({
    this.success = false,
    this.errorCode,
    this.message,
    final Map<String, List<String>> errors = const {},
    this.timestamp,
  }) : _errors = errors;

  factory _$ApiErrorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiErrorModelImplFromJson(json);

  /// هل العملية ناجحة؟ — دائماً false هنا
  @override
  @JsonKey()
  final bool success;

  /// كود الخطأ من الـ Backend (مثلاً "USER_NOT_FOUND")
  @override
  final String? errorCode;

  /// رسالة تقنية من الـ Server (للـ Logging، لا للعرض المباشر)
  @override
  final String? message;

  /// أخطاء التحقق: Map من اسم الحقل → قائمة الأخطاء
  /// { "email": ["مستخدم مسبقاً"], "password": ["قصيرة جداً"] }
  final Map<String, List<String>> _errors;

  /// أخطاء التحقق: Map من اسم الحقل → قائمة الأخطاء
  /// { "email": ["مستخدم مسبقاً"], "password": ["قصيرة جداً"] }
  @override
  @JsonKey()
  Map<String, List<String>> get errors {
    if (_errors is EqualUnmodifiableMapView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_errors);
  }

  /// طابع التوقيت للخطأ
  @override
  final String? timestamp;

  @override
  String toString() {
    return 'ApiErrorModel(success: $success, errorCode: $errorCode, message: $message, errors: $errors, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiErrorModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    errorCode,
    message,
    const DeepCollectionEquality().hash(_errors),
    timestamp,
  );

  /// Create a copy of ApiErrorModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiErrorModelImplCopyWith<_$ApiErrorModelImpl> get copyWith =>
      __$$ApiErrorModelImplCopyWithImpl<_$ApiErrorModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiErrorModelImplToJson(this);
  }
}

abstract class _ApiErrorModel implements ApiErrorModel {
  const factory _ApiErrorModel({
    final bool success,
    final String? errorCode,
    final String? message,
    final Map<String, List<String>> errors,
    final String? timestamp,
  }) = _$ApiErrorModelImpl;

  factory _ApiErrorModel.fromJson(Map<String, dynamic> json) =
      _$ApiErrorModelImpl.fromJson;

  /// هل العملية ناجحة؟ — دائماً false هنا
  @override
  bool get success;

  /// كود الخطأ من الـ Backend (مثلاً "USER_NOT_FOUND")
  @override
  String? get errorCode;

  /// رسالة تقنية من الـ Server (للـ Logging، لا للعرض المباشر)
  @override
  String? get message;

  /// أخطاء التحقق: Map من اسم الحقل → قائمة الأخطاء
  /// { "email": ["مستخدم مسبقاً"], "password": ["قصيرة جداً"] }
  @override
  Map<String, List<String>> get errors;

  /// طابع التوقيت للخطأ
  @override
  String? get timestamp;

  /// Create a copy of ApiErrorModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiErrorModelImplCopyWith<_$ApiErrorModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
