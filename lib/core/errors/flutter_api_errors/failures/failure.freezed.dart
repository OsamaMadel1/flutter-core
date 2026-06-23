// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Failure {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool retryable) network,
    required TResult Function(String message, bool retryable) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message, String? errorCode, bool retryable)
    server,
    required TResult Function(String message, String? resourceType) notFound,
    required TResult Function(String message, String? field) conflict,
    required TResult Function(String message, Map<String, List<String>> errors)
    validation,
    required TResult Function(String message, String? details) parsing,
    required TResult Function(int statusCode, String message, String? errorCode)
    httpError,
    required TResult Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )
    unexpected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, bool retryable)? network,
    TResult? Function(String message, bool retryable)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message, String? errorCode, bool retryable)?
    server,
    TResult? Function(String message, String? resourceType)? notFound,
    TResult? Function(String message, String? field)? conflict,
    TResult? Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult? Function(String message, String? details)? parsing,
    TResult? Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult? Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )?
    unexpected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool retryable)? network,
    TResult Function(String message, bool retryable)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message, String? errorCode, bool retryable)? server,
    TResult Function(String message, String? resourceType)? notFound,
    TResult Function(String message, String? field)? conflict,
    TResult Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult Function(String message, String? details)? parsing,
    TResult Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult Function(String message, Object? exception, StackTrace? stackTrace)?
    unexpected,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(ServerFailure value) server,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ParsingFailure value) parsing,
    required TResult Function(HttpErrorFailure value) httpError,
    required TResult Function(UnexpectedFailure value) unexpected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ParsingFailure value)? parsing,
    TResult? Function(HttpErrorFailure value)? httpError,
    TResult? Function(UnexpectedFailure value)? unexpected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(ServerFailure value)? server,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ParsingFailure value)? parsing,
    TResult Function(HttpErrorFailure value)? httpError,
    TResult Function(UnexpectedFailure value)? unexpected,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FailureCopyWith<Failure> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res, Failure>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$FailureCopyWithImpl<$Res, $Val extends Failure>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NetworkFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$NetworkFailureImplCopyWith(
    _$NetworkFailureImpl value,
    $Res Function(_$NetworkFailureImpl) then,
  ) = __$$NetworkFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, bool retryable});
}

/// @nodoc
class __$$NetworkFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NetworkFailureImpl>
    implements _$$NetworkFailureImplCopyWith<$Res> {
  __$$NetworkFailureImplCopyWithImpl(
    _$NetworkFailureImpl _value,
    $Res Function(_$NetworkFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? retryable = null}) {
    return _then(
      _$NetworkFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        retryable: null == retryable
            ? _value.retryable
            : retryable // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$NetworkFailureImpl implements NetworkFailure {
  const _$NetworkFailureImpl({
    this.message = 'لا يوجد اتصال بالإنترنت',
    this.retryable = true,
  });

  @override
  @JsonKey()
  final String message;

  /// هل يجب إعادة المحاولة تلقائياً؟
  @override
  @JsonKey()
  final bool retryable;

  @override
  String toString() {
    return 'Failure.network(message: $message, retryable: $retryable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.retryable, retryable) ||
                other.retryable == retryable));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, retryable);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      __$$NetworkFailureImplCopyWithImpl<_$NetworkFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool retryable) network,
    required TResult Function(String message, bool retryable) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message, String? errorCode, bool retryable)
    server,
    required TResult Function(String message, String? resourceType) notFound,
    required TResult Function(String message, String? field) conflict,
    required TResult Function(String message, Map<String, List<String>> errors)
    validation,
    required TResult Function(String message, String? details) parsing,
    required TResult Function(int statusCode, String message, String? errorCode)
    httpError,
    required TResult Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )
    unexpected,
  }) {
    return network(message, retryable);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, bool retryable)? network,
    TResult? Function(String message, bool retryable)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message, String? errorCode, bool retryable)?
    server,
    TResult? Function(String message, String? resourceType)? notFound,
    TResult? Function(String message, String? field)? conflict,
    TResult? Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult? Function(String message, String? details)? parsing,
    TResult? Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult? Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )?
    unexpected,
  }) {
    return network?.call(message, retryable);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool retryable)? network,
    TResult Function(String message, bool retryable)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message, String? errorCode, bool retryable)? server,
    TResult Function(String message, String? resourceType)? notFound,
    TResult Function(String message, String? field)? conflict,
    TResult Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult Function(String message, String? details)? parsing,
    TResult Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult Function(String message, Object? exception, StackTrace? stackTrace)?
    unexpected,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(message, retryable);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(ServerFailure value) server,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ParsingFailure value) parsing,
    required TResult Function(HttpErrorFailure value) httpError,
    required TResult Function(UnexpectedFailure value) unexpected,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ParsingFailure value)? parsing,
    TResult? Function(HttpErrorFailure value)? httpError,
    TResult? Function(UnexpectedFailure value)? unexpected,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(ServerFailure value)? server,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ParsingFailure value)? parsing,
    TResult Function(HttpErrorFailure value)? httpError,
    TResult Function(UnexpectedFailure value)? unexpected,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class NetworkFailure implements Failure {
  const factory NetworkFailure({final String message, final bool retryable}) =
      _$NetworkFailureImpl;

  @override
  String get message;

  /// هل يجب إعادة المحاولة تلقائياً؟
  bool get retryable;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TimeoutFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$TimeoutFailureImplCopyWith(
    _$TimeoutFailureImpl value,
    $Res Function(_$TimeoutFailureImpl) then,
  ) = __$$TimeoutFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, bool retryable});
}

/// @nodoc
class __$$TimeoutFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$TimeoutFailureImpl>
    implements _$$TimeoutFailureImplCopyWith<$Res> {
  __$$TimeoutFailureImplCopyWithImpl(
    _$TimeoutFailureImpl _value,
    $Res Function(_$TimeoutFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? retryable = null}) {
    return _then(
      _$TimeoutFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        retryable: null == retryable
            ? _value.retryable
            : retryable // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$TimeoutFailureImpl implements TimeoutFailure {
  const _$TimeoutFailureImpl({
    this.message = 'انتهت مهلة الاتصال',
    this.retryable = true,
  });

  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final bool retryable;

  @override
  String toString() {
    return 'Failure.timeout(message: $message, retryable: $retryable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeoutFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.retryable, retryable) ||
                other.retryable == retryable));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, retryable);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeoutFailureImplCopyWith<_$TimeoutFailureImpl> get copyWith =>
      __$$TimeoutFailureImplCopyWithImpl<_$TimeoutFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool retryable) network,
    required TResult Function(String message, bool retryable) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message, String? errorCode, bool retryable)
    server,
    required TResult Function(String message, String? resourceType) notFound,
    required TResult Function(String message, String? field) conflict,
    required TResult Function(String message, Map<String, List<String>> errors)
    validation,
    required TResult Function(String message, String? details) parsing,
    required TResult Function(int statusCode, String message, String? errorCode)
    httpError,
    required TResult Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )
    unexpected,
  }) {
    return timeout(message, retryable);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, bool retryable)? network,
    TResult? Function(String message, bool retryable)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message, String? errorCode, bool retryable)?
    server,
    TResult? Function(String message, String? resourceType)? notFound,
    TResult? Function(String message, String? field)? conflict,
    TResult? Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult? Function(String message, String? details)? parsing,
    TResult? Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult? Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )?
    unexpected,
  }) {
    return timeout?.call(message, retryable);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool retryable)? network,
    TResult Function(String message, bool retryable)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message, String? errorCode, bool retryable)? server,
    TResult Function(String message, String? resourceType)? notFound,
    TResult Function(String message, String? field)? conflict,
    TResult Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult Function(String message, String? details)? parsing,
    TResult Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult Function(String message, Object? exception, StackTrace? stackTrace)?
    unexpected,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout(message, retryable);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(ServerFailure value) server,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ParsingFailure value) parsing,
    required TResult Function(HttpErrorFailure value) httpError,
    required TResult Function(UnexpectedFailure value) unexpected,
  }) {
    return timeout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ParsingFailure value)? parsing,
    TResult? Function(HttpErrorFailure value)? httpError,
    TResult? Function(UnexpectedFailure value)? unexpected,
  }) {
    return timeout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(ServerFailure value)? server,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ParsingFailure value)? parsing,
    TResult Function(HttpErrorFailure value)? httpError,
    TResult Function(UnexpectedFailure value)? unexpected,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout(this);
    }
    return orElse();
  }
}

abstract class TimeoutFailure implements Failure {
  const factory TimeoutFailure({final String message, final bool retryable}) =
      _$TimeoutFailureImpl;

  @override
  String get message;
  bool get retryable;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeoutFailureImplCopyWith<_$TimeoutFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnauthorizedFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$UnauthorizedFailureImplCopyWith(
    _$UnauthorizedFailureImpl value,
    $Res Function(_$UnauthorizedFailureImpl) then,
  ) = __$$UnauthorizedFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UnauthorizedFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$UnauthorizedFailureImpl>
    implements _$$UnauthorizedFailureImplCopyWith<$Res> {
  __$$UnauthorizedFailureImplCopyWithImpl(
    _$UnauthorizedFailureImpl _value,
    $Res Function(_$UnauthorizedFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$UnauthorizedFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UnauthorizedFailureImpl implements UnauthorizedFailure {
  const _$UnauthorizedFailureImpl({
    this.message = 'انتهت جلستك، يرجى تسجيل الدخول',
  });

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'Failure.unauthorized(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnauthorizedFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnauthorizedFailureImplCopyWith<_$UnauthorizedFailureImpl> get copyWith =>
      __$$UnauthorizedFailureImplCopyWithImpl<_$UnauthorizedFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool retryable) network,
    required TResult Function(String message, bool retryable) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message, String? errorCode, bool retryable)
    server,
    required TResult Function(String message, String? resourceType) notFound,
    required TResult Function(String message, String? field) conflict,
    required TResult Function(String message, Map<String, List<String>> errors)
    validation,
    required TResult Function(String message, String? details) parsing,
    required TResult Function(int statusCode, String message, String? errorCode)
    httpError,
    required TResult Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )
    unexpected,
  }) {
    return unauthorized(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, bool retryable)? network,
    TResult? Function(String message, bool retryable)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message, String? errorCode, bool retryable)?
    server,
    TResult? Function(String message, String? resourceType)? notFound,
    TResult? Function(String message, String? field)? conflict,
    TResult? Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult? Function(String message, String? details)? parsing,
    TResult? Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult? Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )?
    unexpected,
  }) {
    return unauthorized?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool retryable)? network,
    TResult Function(String message, bool retryable)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message, String? errorCode, bool retryable)? server,
    TResult Function(String message, String? resourceType)? notFound,
    TResult Function(String message, String? field)? conflict,
    TResult Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult Function(String message, String? details)? parsing,
    TResult Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult Function(String message, Object? exception, StackTrace? stackTrace)?
    unexpected,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(ServerFailure value) server,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ParsingFailure value) parsing,
    required TResult Function(HttpErrorFailure value) httpError,
    required TResult Function(UnexpectedFailure value) unexpected,
  }) {
    return unauthorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ParsingFailure value)? parsing,
    TResult? Function(HttpErrorFailure value)? httpError,
    TResult? Function(UnexpectedFailure value)? unexpected,
  }) {
    return unauthorized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(ServerFailure value)? server,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ParsingFailure value)? parsing,
    TResult Function(HttpErrorFailure value)? httpError,
    TResult Function(UnexpectedFailure value)? unexpected,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(this);
    }
    return orElse();
  }
}

abstract class UnauthorizedFailure implements Failure {
  const factory UnauthorizedFailure({final String message}) =
      _$UnauthorizedFailureImpl;

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnauthorizedFailureImplCopyWith<_$UnauthorizedFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ForbiddenFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ForbiddenFailureImplCopyWith(
    _$ForbiddenFailureImpl value,
    $Res Function(_$ForbiddenFailureImpl) then,
  ) = __$$ForbiddenFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ForbiddenFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ForbiddenFailureImpl>
    implements _$$ForbiddenFailureImplCopyWith<$Res> {
  __$$ForbiddenFailureImplCopyWithImpl(
    _$ForbiddenFailureImpl _value,
    $Res Function(_$ForbiddenFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ForbiddenFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ForbiddenFailureImpl implements ForbiddenFailure {
  const _$ForbiddenFailureImpl({
    this.message = 'ليس لديك صلاحية للقيام بهذا الإجراء',
  });

  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'Failure.forbidden(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForbiddenFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForbiddenFailureImplCopyWith<_$ForbiddenFailureImpl> get copyWith =>
      __$$ForbiddenFailureImplCopyWithImpl<_$ForbiddenFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool retryable) network,
    required TResult Function(String message, bool retryable) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message, String? errorCode, bool retryable)
    server,
    required TResult Function(String message, String? resourceType) notFound,
    required TResult Function(String message, String? field) conflict,
    required TResult Function(String message, Map<String, List<String>> errors)
    validation,
    required TResult Function(String message, String? details) parsing,
    required TResult Function(int statusCode, String message, String? errorCode)
    httpError,
    required TResult Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )
    unexpected,
  }) {
    return forbidden(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, bool retryable)? network,
    TResult? Function(String message, bool retryable)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message, String? errorCode, bool retryable)?
    server,
    TResult? Function(String message, String? resourceType)? notFound,
    TResult? Function(String message, String? field)? conflict,
    TResult? Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult? Function(String message, String? details)? parsing,
    TResult? Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult? Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )?
    unexpected,
  }) {
    return forbidden?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool retryable)? network,
    TResult Function(String message, bool retryable)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message, String? errorCode, bool retryable)? server,
    TResult Function(String message, String? resourceType)? notFound,
    TResult Function(String message, String? field)? conflict,
    TResult Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult Function(String message, String? details)? parsing,
    TResult Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult Function(String message, Object? exception, StackTrace? stackTrace)?
    unexpected,
    required TResult orElse(),
  }) {
    if (forbidden != null) {
      return forbidden(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(ServerFailure value) server,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ParsingFailure value) parsing,
    required TResult Function(HttpErrorFailure value) httpError,
    required TResult Function(UnexpectedFailure value) unexpected,
  }) {
    return forbidden(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ParsingFailure value)? parsing,
    TResult? Function(HttpErrorFailure value)? httpError,
    TResult? Function(UnexpectedFailure value)? unexpected,
  }) {
    return forbidden?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(ServerFailure value)? server,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ParsingFailure value)? parsing,
    TResult Function(HttpErrorFailure value)? httpError,
    TResult Function(UnexpectedFailure value)? unexpected,
    required TResult orElse(),
  }) {
    if (forbidden != null) {
      return forbidden(this);
    }
    return orElse();
  }
}

abstract class ForbiddenFailure implements Failure {
  const factory ForbiddenFailure({final String message}) =
      _$ForbiddenFailureImpl;

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForbiddenFailureImplCopyWith<_$ForbiddenFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ServerFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ServerFailureImplCopyWith(
    _$ServerFailureImpl value,
    $Res Function(_$ServerFailureImpl) then,
  ) = __$$ServerFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? errorCode, bool retryable});
}

/// @nodoc
class __$$ServerFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ServerFailureImpl>
    implements _$$ServerFailureImplCopyWith<$Res> {
  __$$ServerFailureImplCopyWithImpl(
    _$ServerFailureImpl _value,
    $Res Function(_$ServerFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? errorCode = freezed,
    Object? retryable = null,
  }) {
    return _then(
      _$ServerFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        errorCode: freezed == errorCode
            ? _value.errorCode
            : errorCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        retryable: null == retryable
            ? _value.retryable
            : retryable // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ServerFailureImpl implements ServerFailure {
  const _$ServerFailureImpl({
    this.message = 'حدث خطأ في الخادم',
    this.errorCode,
    this.retryable = false,
  });

  @override
  @JsonKey()
  final String message;

  /// كود الخطأ من الـ Server (مثلاً SRV_001)
  @override
  final String? errorCode;
  @override
  @JsonKey()
  final bool retryable;

  @override
  String toString() {
    return 'Failure.server(message: $message, errorCode: $errorCode, retryable: $retryable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode) &&
            (identical(other.retryable, retryable) ||
                other.retryable == retryable));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, errorCode, retryable);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerFailureImplCopyWith<_$ServerFailureImpl> get copyWith =>
      __$$ServerFailureImplCopyWithImpl<_$ServerFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool retryable) network,
    required TResult Function(String message, bool retryable) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message, String? errorCode, bool retryable)
    server,
    required TResult Function(String message, String? resourceType) notFound,
    required TResult Function(String message, String? field) conflict,
    required TResult Function(String message, Map<String, List<String>> errors)
    validation,
    required TResult Function(String message, String? details) parsing,
    required TResult Function(int statusCode, String message, String? errorCode)
    httpError,
    required TResult Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )
    unexpected,
  }) {
    return server(message, errorCode, retryable);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, bool retryable)? network,
    TResult? Function(String message, bool retryable)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message, String? errorCode, bool retryable)?
    server,
    TResult? Function(String message, String? resourceType)? notFound,
    TResult? Function(String message, String? field)? conflict,
    TResult? Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult? Function(String message, String? details)? parsing,
    TResult? Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult? Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )?
    unexpected,
  }) {
    return server?.call(message, errorCode, retryable);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool retryable)? network,
    TResult Function(String message, bool retryable)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message, String? errorCode, bool retryable)? server,
    TResult Function(String message, String? resourceType)? notFound,
    TResult Function(String message, String? field)? conflict,
    TResult Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult Function(String message, String? details)? parsing,
    TResult Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult Function(String message, Object? exception, StackTrace? stackTrace)?
    unexpected,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(message, errorCode, retryable);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(ServerFailure value) server,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ParsingFailure value) parsing,
    required TResult Function(HttpErrorFailure value) httpError,
    required TResult Function(UnexpectedFailure value) unexpected,
  }) {
    return server(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ParsingFailure value)? parsing,
    TResult? Function(HttpErrorFailure value)? httpError,
    TResult? Function(UnexpectedFailure value)? unexpected,
  }) {
    return server?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(ServerFailure value)? server,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ParsingFailure value)? parsing,
    TResult Function(HttpErrorFailure value)? httpError,
    TResult Function(UnexpectedFailure value)? unexpected,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(this);
    }
    return orElse();
  }
}

abstract class ServerFailure implements Failure {
  const factory ServerFailure({
    final String message,
    final String? errorCode,
    final bool retryable,
  }) = _$ServerFailureImpl;

  @override
  String get message;

  /// كود الخطأ من الـ Server (مثلاً SRV_001)
  String? get errorCode;
  bool get retryable;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerFailureImplCopyWith<_$ServerFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NotFoundFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$NotFoundFailureImplCopyWith(
    _$NotFoundFailureImpl value,
    $Res Function(_$NotFoundFailureImpl) then,
  ) = __$$NotFoundFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? resourceType});
}

/// @nodoc
class __$$NotFoundFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NotFoundFailureImpl>
    implements _$$NotFoundFailureImplCopyWith<$Res> {
  __$$NotFoundFailureImplCopyWithImpl(
    _$NotFoundFailureImpl _value,
    $Res Function(_$NotFoundFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? resourceType = freezed}) {
    return _then(
      _$NotFoundFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        resourceType: freezed == resourceType
            ? _value.resourceType
            : resourceType // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$NotFoundFailureImpl implements NotFoundFailure {
  const _$NotFoundFailureImpl({
    this.message = 'البيانات المطلوبة غير موجودة',
    this.resourceType,
  });

  @override
  @JsonKey()
  final String message;
  @override
  final String? resourceType;

  @override
  String toString() {
    return 'Failure.notFound(message: $message, resourceType: $resourceType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotFoundFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.resourceType, resourceType) ||
                other.resourceType == resourceType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, resourceType);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotFoundFailureImplCopyWith<_$NotFoundFailureImpl> get copyWith =>
      __$$NotFoundFailureImplCopyWithImpl<_$NotFoundFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool retryable) network,
    required TResult Function(String message, bool retryable) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message, String? errorCode, bool retryable)
    server,
    required TResult Function(String message, String? resourceType) notFound,
    required TResult Function(String message, String? field) conflict,
    required TResult Function(String message, Map<String, List<String>> errors)
    validation,
    required TResult Function(String message, String? details) parsing,
    required TResult Function(int statusCode, String message, String? errorCode)
    httpError,
    required TResult Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )
    unexpected,
  }) {
    return notFound(message, resourceType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, bool retryable)? network,
    TResult? Function(String message, bool retryable)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message, String? errorCode, bool retryable)?
    server,
    TResult? Function(String message, String? resourceType)? notFound,
    TResult? Function(String message, String? field)? conflict,
    TResult? Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult? Function(String message, String? details)? parsing,
    TResult? Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult? Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )?
    unexpected,
  }) {
    return notFound?.call(message, resourceType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool retryable)? network,
    TResult Function(String message, bool retryable)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message, String? errorCode, bool retryable)? server,
    TResult Function(String message, String? resourceType)? notFound,
    TResult Function(String message, String? field)? conflict,
    TResult Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult Function(String message, String? details)? parsing,
    TResult Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult Function(String message, Object? exception, StackTrace? stackTrace)?
    unexpected,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(message, resourceType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(ServerFailure value) server,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ParsingFailure value) parsing,
    required TResult Function(HttpErrorFailure value) httpError,
    required TResult Function(UnexpectedFailure value) unexpected,
  }) {
    return notFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ParsingFailure value)? parsing,
    TResult? Function(HttpErrorFailure value)? httpError,
    TResult? Function(UnexpectedFailure value)? unexpected,
  }) {
    return notFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(ServerFailure value)? server,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ParsingFailure value)? parsing,
    TResult Function(HttpErrorFailure value)? httpError,
    TResult Function(UnexpectedFailure value)? unexpected,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(this);
    }
    return orElse();
  }
}

abstract class NotFoundFailure implements Failure {
  const factory NotFoundFailure({
    final String message,
    final String? resourceType,
  }) = _$NotFoundFailureImpl;

  @override
  String get message;
  String? get resourceType;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotFoundFailureImplCopyWith<_$NotFoundFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConflictFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ConflictFailureImplCopyWith(
    _$ConflictFailureImpl value,
    $Res Function(_$ConflictFailureImpl) then,
  ) = __$$ConflictFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? field});
}

/// @nodoc
class __$$ConflictFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ConflictFailureImpl>
    implements _$$ConflictFailureImplCopyWith<$Res> {
  __$$ConflictFailureImplCopyWithImpl(
    _$ConflictFailureImpl _value,
    $Res Function(_$ConflictFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? field = freezed}) {
    return _then(
      _$ConflictFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        field: freezed == field
            ? _value.field
            : field // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ConflictFailureImpl implements ConflictFailure {
  const _$ConflictFailureImpl({
    this.message = 'البيانات موجودة مسبقاً',
    this.field,
  });

  @override
  @JsonKey()
  final String message;
  @override
  final String? field;

  @override
  String toString() {
    return 'Failure.conflict(message: $message, field: $field)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConflictFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.field, field) || other.field == field));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, field);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConflictFailureImplCopyWith<_$ConflictFailureImpl> get copyWith =>
      __$$ConflictFailureImplCopyWithImpl<_$ConflictFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool retryable) network,
    required TResult Function(String message, bool retryable) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message, String? errorCode, bool retryable)
    server,
    required TResult Function(String message, String? resourceType) notFound,
    required TResult Function(String message, String? field) conflict,
    required TResult Function(String message, Map<String, List<String>> errors)
    validation,
    required TResult Function(String message, String? details) parsing,
    required TResult Function(int statusCode, String message, String? errorCode)
    httpError,
    required TResult Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )
    unexpected,
  }) {
    return conflict(message, field);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, bool retryable)? network,
    TResult? Function(String message, bool retryable)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message, String? errorCode, bool retryable)?
    server,
    TResult? Function(String message, String? resourceType)? notFound,
    TResult? Function(String message, String? field)? conflict,
    TResult? Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult? Function(String message, String? details)? parsing,
    TResult? Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult? Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )?
    unexpected,
  }) {
    return conflict?.call(message, field);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool retryable)? network,
    TResult Function(String message, bool retryable)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message, String? errorCode, bool retryable)? server,
    TResult Function(String message, String? resourceType)? notFound,
    TResult Function(String message, String? field)? conflict,
    TResult Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult Function(String message, String? details)? parsing,
    TResult Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult Function(String message, Object? exception, StackTrace? stackTrace)?
    unexpected,
    required TResult orElse(),
  }) {
    if (conflict != null) {
      return conflict(message, field);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(ServerFailure value) server,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ParsingFailure value) parsing,
    required TResult Function(HttpErrorFailure value) httpError,
    required TResult Function(UnexpectedFailure value) unexpected,
  }) {
    return conflict(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ParsingFailure value)? parsing,
    TResult? Function(HttpErrorFailure value)? httpError,
    TResult? Function(UnexpectedFailure value)? unexpected,
  }) {
    return conflict?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(ServerFailure value)? server,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ParsingFailure value)? parsing,
    TResult Function(HttpErrorFailure value)? httpError,
    TResult Function(UnexpectedFailure value)? unexpected,
    required TResult orElse(),
  }) {
    if (conflict != null) {
      return conflict(this);
    }
    return orElse();
  }
}

abstract class ConflictFailure implements Failure {
  const factory ConflictFailure({final String message, final String? field}) =
      _$ConflictFailureImpl;

  @override
  String get message;
  String? get field;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConflictFailureImplCopyWith<_$ConflictFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidationFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ValidationFailureImplCopyWith(
    _$ValidationFailureImpl value,
    $Res Function(_$ValidationFailureImpl) then,
  ) = __$$ValidationFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, Map<String, List<String>> errors});
}

/// @nodoc
class __$$ValidationFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ValidationFailureImpl>
    implements _$$ValidationFailureImplCopyWith<$Res> {
  __$$ValidationFailureImplCopyWithImpl(
    _$ValidationFailureImpl _value,
    $Res Function(_$ValidationFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? errors = null}) {
    return _then(
      _$ValidationFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        errors: null == errors
            ? _value._errors
            : errors // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<String>>,
      ),
    );
  }
}

/// @nodoc

class _$ValidationFailureImpl implements ValidationFailure {
  const _$ValidationFailureImpl({
    this.message = 'يوجد أخطاء في البيانات المدخلة',
    final Map<String, List<String>> errors = const {},
  }) : _errors = errors;

  @override
  @JsonKey()
  final String message;
  final Map<String, List<String>> _errors;
  @override
  @JsonKey()
  Map<String, List<String>> get errors {
    if (_errors is EqualUnmodifiableMapView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_errors);
  }

  @override
  String toString() {
    return 'Failure.validation(message: $message, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(_errors),
  );

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      __$$ValidationFailureImplCopyWithImpl<_$ValidationFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool retryable) network,
    required TResult Function(String message, bool retryable) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message, String? errorCode, bool retryable)
    server,
    required TResult Function(String message, String? resourceType) notFound,
    required TResult Function(String message, String? field) conflict,
    required TResult Function(String message, Map<String, List<String>> errors)
    validation,
    required TResult Function(String message, String? details) parsing,
    required TResult Function(int statusCode, String message, String? errorCode)
    httpError,
    required TResult Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )
    unexpected,
  }) {
    return validation(message, errors);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, bool retryable)? network,
    TResult? Function(String message, bool retryable)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message, String? errorCode, bool retryable)?
    server,
    TResult? Function(String message, String? resourceType)? notFound,
    TResult? Function(String message, String? field)? conflict,
    TResult? Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult? Function(String message, String? details)? parsing,
    TResult? Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult? Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )?
    unexpected,
  }) {
    return validation?.call(message, errors);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool retryable)? network,
    TResult Function(String message, bool retryable)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message, String? errorCode, bool retryable)? server,
    TResult Function(String message, String? resourceType)? notFound,
    TResult Function(String message, String? field)? conflict,
    TResult Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult Function(String message, String? details)? parsing,
    TResult Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult Function(String message, Object? exception, StackTrace? stackTrace)?
    unexpected,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(message, errors);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(ServerFailure value) server,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ParsingFailure value) parsing,
    required TResult Function(HttpErrorFailure value) httpError,
    required TResult Function(UnexpectedFailure value) unexpected,
  }) {
    return validation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ParsingFailure value)? parsing,
    TResult? Function(HttpErrorFailure value)? httpError,
    TResult? Function(UnexpectedFailure value)? unexpected,
  }) {
    return validation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(ServerFailure value)? server,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ParsingFailure value)? parsing,
    TResult Function(HttpErrorFailure value)? httpError,
    TResult Function(UnexpectedFailure value)? unexpected,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(this);
    }
    return orElse();
  }
}

abstract class ValidationFailure implements Failure {
  const factory ValidationFailure({
    final String message,
    final Map<String, List<String>> errors,
  }) = _$ValidationFailureImpl;

  @override
  String get message;
  Map<String, List<String>> get errors;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ParsingFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ParsingFailureImplCopyWith(
    _$ParsingFailureImpl value,
    $Res Function(_$ParsingFailureImpl) then,
  ) = __$$ParsingFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? details});
}

/// @nodoc
class __$$ParsingFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ParsingFailureImpl>
    implements _$$ParsingFailureImplCopyWith<$Res> {
  __$$ParsingFailureImplCopyWithImpl(
    _$ParsingFailureImpl _value,
    $Res Function(_$ParsingFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? details = freezed}) {
    return _then(
      _$ParsingFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        details: freezed == details
            ? _value.details
            : details // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ParsingFailureImpl implements ParsingFailure {
  const _$ParsingFailureImpl({
    this.message = 'تعذّر معالجة البيانات الواردة',
    this.details,
  });

  @override
  @JsonKey()
  final String message;
  @override
  final String? details;

  @override
  String toString() {
    return 'Failure.parsing(message: $message, details: $details)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParsingFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.details, details) || other.details == details));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, details);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParsingFailureImplCopyWith<_$ParsingFailureImpl> get copyWith =>
      __$$ParsingFailureImplCopyWithImpl<_$ParsingFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool retryable) network,
    required TResult Function(String message, bool retryable) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message, String? errorCode, bool retryable)
    server,
    required TResult Function(String message, String? resourceType) notFound,
    required TResult Function(String message, String? field) conflict,
    required TResult Function(String message, Map<String, List<String>> errors)
    validation,
    required TResult Function(String message, String? details) parsing,
    required TResult Function(int statusCode, String message, String? errorCode)
    httpError,
    required TResult Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )
    unexpected,
  }) {
    return parsing(message, details);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, bool retryable)? network,
    TResult? Function(String message, bool retryable)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message, String? errorCode, bool retryable)?
    server,
    TResult? Function(String message, String? resourceType)? notFound,
    TResult? Function(String message, String? field)? conflict,
    TResult? Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult? Function(String message, String? details)? parsing,
    TResult? Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult? Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )?
    unexpected,
  }) {
    return parsing?.call(message, details);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool retryable)? network,
    TResult Function(String message, bool retryable)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message, String? errorCode, bool retryable)? server,
    TResult Function(String message, String? resourceType)? notFound,
    TResult Function(String message, String? field)? conflict,
    TResult Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult Function(String message, String? details)? parsing,
    TResult Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult Function(String message, Object? exception, StackTrace? stackTrace)?
    unexpected,
    required TResult orElse(),
  }) {
    if (parsing != null) {
      return parsing(message, details);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(ServerFailure value) server,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ParsingFailure value) parsing,
    required TResult Function(HttpErrorFailure value) httpError,
    required TResult Function(UnexpectedFailure value) unexpected,
  }) {
    return parsing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ParsingFailure value)? parsing,
    TResult? Function(HttpErrorFailure value)? httpError,
    TResult? Function(UnexpectedFailure value)? unexpected,
  }) {
    return parsing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(ServerFailure value)? server,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ParsingFailure value)? parsing,
    TResult Function(HttpErrorFailure value)? httpError,
    TResult Function(UnexpectedFailure value)? unexpected,
    required TResult orElse(),
  }) {
    if (parsing != null) {
      return parsing(this);
    }
    return orElse();
  }
}

abstract class ParsingFailure implements Failure {
  const factory ParsingFailure({final String message, final String? details}) =
      _$ParsingFailureImpl;

  @override
  String get message;
  String? get details;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParsingFailureImplCopyWith<_$ParsingFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HttpErrorFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$HttpErrorFailureImplCopyWith(
    _$HttpErrorFailureImpl value,
    $Res Function(_$HttpErrorFailureImpl) then,
  ) = __$$HttpErrorFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int statusCode, String message, String? errorCode});
}

/// @nodoc
class __$$HttpErrorFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$HttpErrorFailureImpl>
    implements _$$HttpErrorFailureImplCopyWith<$Res> {
  __$$HttpErrorFailureImplCopyWithImpl(
    _$HttpErrorFailureImpl _value,
    $Res Function(_$HttpErrorFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? message = null,
    Object? errorCode = freezed,
  }) {
    return _then(
      _$HttpErrorFailureImpl(
        statusCode: null == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as int,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        errorCode: freezed == errorCode
            ? _value.errorCode
            : errorCode // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$HttpErrorFailureImpl implements HttpErrorFailure {
  const _$HttpErrorFailureImpl({
    required this.statusCode,
    this.message = 'حدث خطأ غير متوقع',
    this.errorCode,
  });

  @override
  final int statusCode;
  @override
  @JsonKey()
  final String message;
  @override
  final String? errorCode;

  @override
  String toString() {
    return 'Failure.httpError(statusCode: $statusCode, message: $message, errorCode: $errorCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HttpErrorFailureImpl &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, statusCode, message, errorCode);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HttpErrorFailureImplCopyWith<_$HttpErrorFailureImpl> get copyWith =>
      __$$HttpErrorFailureImplCopyWithImpl<_$HttpErrorFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool retryable) network,
    required TResult Function(String message, bool retryable) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message, String? errorCode, bool retryable)
    server,
    required TResult Function(String message, String? resourceType) notFound,
    required TResult Function(String message, String? field) conflict,
    required TResult Function(String message, Map<String, List<String>> errors)
    validation,
    required TResult Function(String message, String? details) parsing,
    required TResult Function(int statusCode, String message, String? errorCode)
    httpError,
    required TResult Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )
    unexpected,
  }) {
    return httpError(statusCode, message, errorCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, bool retryable)? network,
    TResult? Function(String message, bool retryable)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message, String? errorCode, bool retryable)?
    server,
    TResult? Function(String message, String? resourceType)? notFound,
    TResult? Function(String message, String? field)? conflict,
    TResult? Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult? Function(String message, String? details)? parsing,
    TResult? Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult? Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )?
    unexpected,
  }) {
    return httpError?.call(statusCode, message, errorCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool retryable)? network,
    TResult Function(String message, bool retryable)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message, String? errorCode, bool retryable)? server,
    TResult Function(String message, String? resourceType)? notFound,
    TResult Function(String message, String? field)? conflict,
    TResult Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult Function(String message, String? details)? parsing,
    TResult Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult Function(String message, Object? exception, StackTrace? stackTrace)?
    unexpected,
    required TResult orElse(),
  }) {
    if (httpError != null) {
      return httpError(statusCode, message, errorCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(ServerFailure value) server,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ParsingFailure value) parsing,
    required TResult Function(HttpErrorFailure value) httpError,
    required TResult Function(UnexpectedFailure value) unexpected,
  }) {
    return httpError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ParsingFailure value)? parsing,
    TResult? Function(HttpErrorFailure value)? httpError,
    TResult? Function(UnexpectedFailure value)? unexpected,
  }) {
    return httpError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(ServerFailure value)? server,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ParsingFailure value)? parsing,
    TResult Function(HttpErrorFailure value)? httpError,
    TResult Function(UnexpectedFailure value)? unexpected,
    required TResult orElse(),
  }) {
    if (httpError != null) {
      return httpError(this);
    }
    return orElse();
  }
}

abstract class HttpErrorFailure implements Failure {
  const factory HttpErrorFailure({
    required final int statusCode,
    final String message,
    final String? errorCode,
  }) = _$HttpErrorFailureImpl;

  int get statusCode;
  @override
  String get message;
  String? get errorCode;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HttpErrorFailureImplCopyWith<_$HttpErrorFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnexpectedFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$UnexpectedFailureImplCopyWith(
    _$UnexpectedFailureImpl value,
    $Res Function(_$UnexpectedFailureImpl) then,
  ) = __$$UnexpectedFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, Object? exception, StackTrace? stackTrace});
}

/// @nodoc
class __$$UnexpectedFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$UnexpectedFailureImpl>
    implements _$$UnexpectedFailureImplCopyWith<$Res> {
  __$$UnexpectedFailureImplCopyWithImpl(
    _$UnexpectedFailureImpl _value,
    $Res Function(_$UnexpectedFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? exception = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(
      _$UnexpectedFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        exception: freezed == exception ? _value.exception : exception,
        stackTrace: freezed == stackTrace
            ? _value.stackTrace
            : stackTrace // ignore: cast_nullable_to_non_nullable
                  as StackTrace?,
      ),
    );
  }
}

/// @nodoc

class _$UnexpectedFailureImpl implements UnexpectedFailure {
  const _$UnexpectedFailureImpl({
    this.message = 'حدث خطأ غير متوقع',
    this.exception,
    this.stackTrace,
  });

  @override
  @JsonKey()
  final String message;
  @override
  final Object? exception;
  @override
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'Failure.unexpected(message: $message, exception: $exception, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnexpectedFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.exception, exception) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(exception),
    stackTrace,
  );

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnexpectedFailureImplCopyWith<_$UnexpectedFailureImpl> get copyWith =>
      __$$UnexpectedFailureImplCopyWithImpl<_$UnexpectedFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, bool retryable) network,
    required TResult Function(String message, bool retryable) timeout,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) forbidden,
    required TResult Function(String message, String? errorCode, bool retryable)
    server,
    required TResult Function(String message, String? resourceType) notFound,
    required TResult Function(String message, String? field) conflict,
    required TResult Function(String message, Map<String, List<String>> errors)
    validation,
    required TResult Function(String message, String? details) parsing,
    required TResult Function(int statusCode, String message, String? errorCode)
    httpError,
    required TResult Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )
    unexpected,
  }) {
    return unexpected(message, exception, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, bool retryable)? network,
    TResult? Function(String message, bool retryable)? timeout,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? forbidden,
    TResult? Function(String message, String? errorCode, bool retryable)?
    server,
    TResult? Function(String message, String? resourceType)? notFound,
    TResult? Function(String message, String? field)? conflict,
    TResult? Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult? Function(String message, String? details)? parsing,
    TResult? Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult? Function(
      String message,
      Object? exception,
      StackTrace? stackTrace,
    )?
    unexpected,
  }) {
    return unexpected?.call(message, exception, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, bool retryable)? network,
    TResult Function(String message, bool retryable)? timeout,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? forbidden,
    TResult Function(String message, String? errorCode, bool retryable)? server,
    TResult Function(String message, String? resourceType)? notFound,
    TResult Function(String message, String? field)? conflict,
    TResult Function(String message, Map<String, List<String>> errors)?
    validation,
    TResult Function(String message, String? details)? parsing,
    TResult Function(int statusCode, String message, String? errorCode)?
    httpError,
    TResult Function(String message, Object? exception, StackTrace? stackTrace)?
    unexpected,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected(message, exception, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(ForbiddenFailure value) forbidden,
    required TResult Function(ServerFailure value) server,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ConflictFailure value) conflict,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ParsingFailure value) parsing,
    required TResult Function(HttpErrorFailure value) httpError,
    required TResult Function(UnexpectedFailure value) unexpected,
  }) {
    return unexpected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(ForbiddenFailure value)? forbidden,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ConflictFailure value)? conflict,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ParsingFailure value)? parsing,
    TResult? Function(HttpErrorFailure value)? httpError,
    TResult? Function(UnexpectedFailure value)? unexpected,
  }) {
    return unexpected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(ForbiddenFailure value)? forbidden,
    TResult Function(ServerFailure value)? server,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ConflictFailure value)? conflict,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ParsingFailure value)? parsing,
    TResult Function(HttpErrorFailure value)? httpError,
    TResult Function(UnexpectedFailure value)? unexpected,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected(this);
    }
    return orElse();
  }
}

abstract class UnexpectedFailure implements Failure {
  const factory UnexpectedFailure({
    final String message,
    final Object? exception,
    final StackTrace? stackTrace,
  }) = _$UnexpectedFailureImpl;

  @override
  String get message;
  Object? get exception;
  StackTrace? get stackTrace;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnexpectedFailureImplCopyWith<_$UnexpectedFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
