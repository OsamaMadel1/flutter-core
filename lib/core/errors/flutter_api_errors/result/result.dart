// =============================================================================
// result.dart
// =============================================================================
// نمط "Railway Oriented Programming" — كل عملية إما تنجح (Success) أو تفشل (Failure)
// الـ UI لا يتعامل مع Exceptions أبداً، فقط مع Result.
//
// الاستخدام:
//   Result<UserModel>  → إما Right(user) أو Left(failure)
//   result.fold(
//     (failure) => showError(failure),
//     (user)    => showUser(user),
//   )
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';
import '../failures/failure.dart';

part 'result.freezed.dart';

/// [Result<T>] — يمثل نتيجة أي عملية غير متزامنة.
///
/// - [T] : نوع البيانات عند النجاح
/// - يُستخدم كـ Return Type لكل Repository و UseCase
@freezed
sealed class Result<T> with _$Result<T> {
  /// ✅ نجاح العملية — يحمل البيانات الفعلية
  const factory Result.success(T data) = Success<T>;

  /// ❌ فشل العملية — يحمل Failure موصوف
  const factory Result.failure(Failure failure) = Failure_<T>;
}

// =============================================================================
// Extensions — لجعل الاستخدام أبسط وأكثر قراءةً
// =============================================================================
extension ResultExtension<T> on Result<T> {
  /// هل النتيجة ناجحة؟
  bool get isSuccess => this is Success<T>;

  /// هل النتيجة فاشلة؟
  bool get isFailure => this is Failure_<T>;

  /// استخرج البيانات عند النجاح — يُعيد null عند الفشل
  T? get dataOrNull => switch (this) {
        Success(:final data) => data,
        _ => null,
      };

  /// استخرج الـ Failure — يُعيد null عند النجاح
  Failure? get failureOrNull => switch (this) {
        Failure_(:final failure) => failure,
        _ => null,
      };

  /// [fold] — يُنفّذ أحد الـ callbacks بحسب الحالة (مثل Either)
  ///
  /// مثال:
  /// ```dart
  /// result.fold(
  ///   onFailure: (f) => state = ErrorState(f.message),
  ///   onSuccess: (d) => state = LoadedState(d),
  /// );
  /// ```
  R fold<R>({
    required R Function(Failure failure) onFailure,
    required R Function(T data) onSuccess,
  }) {
    return switch (this) {
      Success(:final data) => onSuccess(data),
      Failure_(:final failure) => onFailure(failure),
    };
  }

  /// [map] — حوّل البيانات عند النجاح دون المساس بالـ Failure
  Result<R> map<R>(R Function(T data) transform) {
    return switch (this) {
      Success(:final data) => Result.success(transform(data)),
      Failure_(:final failure) => Result.failure(failure),
    };
  }

  /// [getOrElse] — أعطِ قيمة افتراضية عند الفشل
  T getOrElse(T defaultValue) => dataOrNull ?? defaultValue;
}
