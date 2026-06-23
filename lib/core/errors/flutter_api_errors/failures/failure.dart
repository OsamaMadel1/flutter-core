// =============================================================================
// failure.dart
// =============================================================================
// جميع أنواع الفشل الممكنة في التطبيق مُعرَّفة هنا.
//
// المبدأ: الـ UI يتعامل فقط مع [Failure] — لا يعرف إن كان الخطأ من Network
// أو Server أو Validation أو Token. هذا هو جوهر Clean Architecture.
//
// sealed class → Dart يضمن exhaustive matching في switch
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

/// [Failure] — Base sealed class لجميع حالات الفشل
@freezed
sealed class Failure with _$Failure {
  // ---------------------------------------------------------------------------
  // 🌐 أخطاء الشبكة — قابلة للـ Retry دائماً
  // ---------------------------------------------------------------------------

  /// انقطع الاتصال بالإنترنت أو تعذّر الوصول للـ Server
  const factory Failure.network({
    @Default('لا يوجد اتصال بالإنترنت') String message,
    /// هل يجب إعادة المحاولة تلقائياً؟
    @Default(true) bool retryable,
  }) = NetworkFailure;

  /// انتهى وقت الاتصال (Timeout)
  const factory Failure.timeout({
    @Default('انتهت مهلة الاتصال') String message,
    @Default(true) bool retryable,
  }) = TimeoutFailure;

  // ---------------------------------------------------------------------------
  // 🔐 أخطاء المصادقة والصلاحيات — غير قابلة للـ Retry
  // ---------------------------------------------------------------------------

  /// انتهت صلاحية الـ Token أو لم يتم تجديده
  const factory Failure.unauthorized({
    @Default('انتهت جلستك، يرجى تسجيل الدخول') String message,
  }) = UnauthorizedFailure;

  /// المستخدم لا يملك صلاحية للوصول لهذا المورد
  const factory Failure.forbidden({
    @Default('ليس لديك صلاحية للقيام بهذا الإجراء') String message,
  }) = ForbiddenFailure;

  // ---------------------------------------------------------------------------
  // 🖥️ أخطاء الـ Server — قد تكون قابلة للـ Retry
  // ---------------------------------------------------------------------------

  /// خطأ داخلي في الـ Server (5xx)
  const factory Failure.server({
    @Default('حدث خطأ في الخادم') String message,
    /// كود الخطأ من الـ Server (مثلاً SRV_001)
    String? errorCode,
    @Default(false) bool retryable,
  }) = ServerFailure;

  /// المورد المطلوب غير موجود (404)
  const factory Failure.notFound({
    @Default('البيانات المطلوبة غير موجودة') String message,
    String? resourceType,
  }) = NotFoundFailure;

  /// تعارض في البيانات (409) — مثل تكرار البريد الإلكتروني
  const factory Failure.conflict({
    @Default('البيانات موجودة مسبقاً') String message,
    String? field,
  }) = ConflictFailure;

  // ---------------------------------------------------------------------------
  // ✏️ أخطاء التحقق من البيانات — تُعاد للـ UI مباشرةً
  // ---------------------------------------------------------------------------

  /// فشل التحقق من المدخلات (422)
  /// [errors] : Map من اسم الحقل إلى قائمة الأخطاء
  /// مثال: {'email': ['البريد غير صالح'], 'phone': ['الرقم مكرر']}
  const factory Failure.validation({
    @Default('يوجد أخطاء في البيانات المدخلة') String message,
    @Default({}) Map<String, List<String>> errors,
  }) = ValidationFailure;

  // ---------------------------------------------------------------------------
  // 📡 أخطاء الـ Response — مشكلة في تنسيق البيانات
  // ---------------------------------------------------------------------------

  /// فشل تحليل (Parsing) الـ Response JSON
  const factory Failure.parsing({
    @Default('تعذّر معالجة البيانات الواردة') String message,
    String? details,
  }) = ParsingFailure;

  // ---------------------------------------------------------------------------
  // 🔢 أخطاء HTTP العامة — لكل كود غير مُغطَّى أعلاه
  // ---------------------------------------------------------------------------

  /// أي خطأ HTTP غير مُصنَّف في الأنواع أعلاه
  const factory Failure.httpError({
    required int statusCode,
    @Default('حدث خطأ غير متوقع') String message,
    String? errorCode,
  }) = HttpErrorFailure;

  // ---------------------------------------------------------------------------
  // ❓ أخطاء غير متوقعة — آخر خط دفاع
  // ---------------------------------------------------------------------------

  /// أي استثناء لم يُتوقع — يجب تسجيله في Crashlytics/Sentry
  const factory Failure.unexpected({
    @Default('حدث خطأ غير متوقع') String message,
    Object? exception,
    StackTrace? stackTrace,
  }) = UnexpectedFailure;
}

// =============================================================================
// Extensions — خصائص مشتقة مشتركة بين جميع أنواع الـ Failure
// =============================================================================
extension FailureExtension on Failure {
  /// رسالة الخطأ القابلة للعرض في الـ UI
  String get displayMessage => switch (this) {
        NetworkFailure(:final message) => message,
        TimeoutFailure(:final message) => message,
        UnauthorizedFailure(:final message) => message,
        ForbiddenFailure(:final message) => message,
        ServerFailure(:final message) => message,
        NotFoundFailure(:final message) => message,
        ConflictFailure(:final message) => message,
        ValidationFailure(:final message) => message,
        ParsingFailure(:final message) => message,
        HttpErrorFailure(:final message) => message,
        UnexpectedFailure(:final message) => message,
      };

  /// هل يجب إعادة المحاولة؟
  /// — Network و Timeout → نعم دائماً
  /// — Server → حسب الـ flag
  /// — باقي الأنواع → لا
  bool get isRetryable => switch (this) {
        NetworkFailure(:final retryable) => retryable,
        TimeoutFailure(:final retryable) => retryable,
        ServerFailure(:final retryable) => retryable,
        _ => false,
      };

  /// هل يجب إعادة تسجيل الدخول؟ (توجيه لشاشة Login)
  bool get requiresReauthentication => this is UnauthorizedFailure;

  /// هل يجب تسجيل الخطأ في Crashlytics/Sentry؟
  bool get shouldLog => switch (this) {
        UnexpectedFailure() => true,
        ServerFailure() => true,
        ParsingFailure() => true,
        _ => false,
      };
}
