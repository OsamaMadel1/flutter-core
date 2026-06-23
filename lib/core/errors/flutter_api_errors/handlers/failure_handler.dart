// =============================================================================
// failure_handler.dart
// =============================================================================
// معالج الـ Failures في طبقة الـ UI / ViewModel.
//
// المسؤولية:
//   - تحويل Failure إلى رسالة قابلة للعرض
//   - تحديد نوع العرض (Snackbar / Dialog / Inline)
//   - التعامل مع أخطاء Validation بشكل منظم
//   - تسجيل الأخطاء الخطيرة
//
// الاستخدام في Riverpod Notifier:
// ```dart
// final result = await _repository.getUsers();
// result.fold(
//   onFailure: (f) => FailureHandler.handle(f, context: context),
//   onSuccess: (data) => state = AsyncData(data),
// );
// ```
// =============================================================================

import '../failures/failure.dart';

// =============================================================================
// أنواع طريقة عرض الخطأ
// =============================================================================

/// [ErrorDisplayType] — يُحدد كيف يُعرض الخطأ في الـ UI
enum ErrorDisplayType {
  /// شريط سفلي مؤقت — للأخطاء العابرة
  snackbar,

  /// نافذة حوار — للأخطاء الحرجة التي تحتاج قرار المستخدم
  dialog,

  /// خطأ مضمّن بجانب حقل الإدخال — لأخطاء الـ Validation
  inline,

  /// شاشة خطأ كاملة — للأخطاء المانعة للاستخدام
  fullScreen,
}

// =============================================================================
// نموذج حالة الخطأ
// =============================================================================

/// [ErrorState] — يُمثّل حالة الخطأ الجاهزة للـ UI
class ErrorState {
  const ErrorState({
    required this.message,
    required this.displayType,
    this.validationErrors = const {},
    this.canRetry = false,
    this.requiresReauth = false,
    this.actionLabel,
    this.onAction,
  });

  /// الرسالة القابلة للعرض للمستخدم
  final String message;

  /// كيفية عرض الخطأ
  final ErrorDisplayType displayType;

  /// أخطاء الحقول (للـ Validation)
  final Map<String, List<String>> validationErrors;

  /// هل يمكن إعادة المحاولة؟ — لعرض زر "إعادة المحاولة"
  final bool canRetry;

  /// هل يحتاج إعادة تسجيل الدخول؟ — لتوجيه لشاشة Login
  final bool requiresReauth;

  /// نص زر الإجراء (مثلاً "تسجيل الدخول" أو "إعادة المحاولة")
  final String? actionLabel;

  /// ماذا يحدث عند الضغط على زر الإجراء
  final void Function()? onAction;

  /// استرجع خطأ حقل محدد (أول رسالة)
  String? fieldError(String fieldName) {
    return validationErrors[fieldName]?.firstOrNull;
  }

  /// هل يوجد خطأ في حقل محدد؟
  bool hasFieldError(String fieldName) {
    return validationErrors.containsKey(fieldName) &&
        validationErrors[fieldName]!.isNotEmpty;
  }
}

// =============================================================================
// معالج الـ Failures
// =============================================================================

/// [FailureHandler] — يُحوّل Failure إلى ErrorState جاهز للـ UI
abstract final class FailureHandler {
  /// النقطة الرئيسية للمعالجة
  ///
  /// [onReauth] — استدعِ هذا عند الحاجة لإعادة تسجيل الدخول
  static ErrorState handle(
    Failure failure, {
    void Function()? onRetry,
    void Function()? onReauth,
  }) {
    // سجّل الأخطاء الخطيرة
    if (failure.shouldLog) {
      _logFailure(failure);
    }

    return switch (failure) {
      // --- شبكة: Snackbar + زر إعادة المحاولة ---
      NetworkFailure(:final message) => ErrorState(
          message: message,
          displayType: ErrorDisplayType.snackbar,
          canRetry: true,
          actionLabel: onRetry != null ? 'إعادة المحاولة' : null,
          onAction: onRetry,
        ),

      // --- Timeout: مثل الشبكة ---
      TimeoutFailure(:final message) => ErrorState(
          message: message,
          displayType: ErrorDisplayType.snackbar,
          canRetry: true,
          actionLabel: onRetry != null ? 'إعادة المحاولة' : null,
          onAction: onRetry,
        ),

      // --- غير مصرح: Dialog + زر تسجيل الدخول ---
      UnauthorizedFailure(:final message) => ErrorState(
          message: message,
          displayType: ErrorDisplayType.dialog,
          requiresReauth: true,
          actionLabel: 'تسجيل الدخول',
          onAction: onReauth,
        ),

      // --- محظور: Snackbar بدون إجراء ---
      ForbiddenFailure(:final message) => ErrorState(
          message: message,
          displayType: ErrorDisplayType.snackbar,
        ),

      // --- غير موجود: Snackbar ---
      NotFoundFailure(:final message) => ErrorState(
          message: message,
          displayType: ErrorDisplayType.snackbar,
        ),

      // --- تعارض: Snackbar ---
      ConflictFailure(:final message) => ErrorState(
          message: message,
          displayType: ErrorDisplayType.snackbar,
        ),

      // --- Validation: Inline مع خريطة الأخطاء ---
      ValidationFailure(:final message, :final errors) => ErrorState(
          message: message,
          displayType: ErrorDisplayType.inline,
          validationErrors: errors,
        ),

      // --- Parsing: Snackbar عام ---
      ParsingFailure(:final message) => ErrorState(
          message: message,
          displayType: ErrorDisplayType.snackbar,
        ),

      // --- Server: Dialog + زر إعادة المحاولة ---
      ServerFailure(:final message, :final retryable) => ErrorState(
          message: message,
          displayType: ErrorDisplayType.dialog,
          canRetry: retryable,
          actionLabel: retryable && onRetry != null ? 'إعادة المحاولة' : null,
          onAction: retryable ? onRetry : null,
        ),

      // --- HTTP عام: Snackbar ---
      HttpErrorFailure(:final message) => ErrorState(
          message: message,
          displayType: ErrorDisplayType.snackbar,
        ),

      // --- غير متوقع: Full Screen (خطأ حرج) ---
      UnexpectedFailure(:final message) => ErrorState(
          message: message,
          displayType: ErrorDisplayType.fullScreen,
          canRetry: onRetry != null,
          actionLabel: onRetry != null ? 'إعادة المحاولة' : null,
          onAction: onRetry,
        ),
    };
  }

  // ---------------------------------------------------------------------------
  // Logging — استبدل بـ Crashlytics أو Sentry في الإنتاج
  // ---------------------------------------------------------------------------
  static void _logFailure(Failure failure) {
    // في الإنتاج:
    // FirebaseCrashlytics.instance.recordError(failure, stackTrace);
    // Sentry.captureException(failure);
    // ignore: avoid_print
    print('[FailureHandler] 🔴 Logged: $failure');
  }
}
