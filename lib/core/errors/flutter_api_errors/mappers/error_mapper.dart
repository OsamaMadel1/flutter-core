// =============================================================================
// error_mapper.dart
// =============================================================================
// يُترجم [ApiException] → [Failure].
//
// هذا هو العقل الرئيسي لنظام الأخطاء:
// - يُصنّف الخطأ بدقة
// - يُحدد قابلية الـ Retry
// - يُترجم كودات الـ Backend إلى رسائل عربية
// - يُسجّل الأخطاء للـ Monitoring
//
// المبدأ المهم:
//   أخطاء قابلة للـ Retry   → Network, Timeout, 503
//   أخطاء غير قابلة للـ Retry → 401, 403, 404, 422, 400
//   أخطاء الـ Server (5xx)  → حسب طبيعة الخطأ
// =============================================================================

import '../codes/api_error_codes.dart';
import '../exceptions/api_exception.dart';
import '../failures/failure.dart';

/// [ErrorMapper] — يُحوّل ApiException إلى Failure مُصنَّف
abstract final class ErrorMapper {
  /// النقطة الرئيسية للتحويل
  ///
  /// يُستدعى من Repository بعد اعتراض أي ApiException:
  /// ```dart
  /// try {
  ///   final data = await remoteDataSource.getUser(id);
  ///   return Result.success(data);
  /// } on ApiException catch (e) {
  ///   return Result.failure(ErrorMapper.map(e));
  /// }
  /// ```
  static Failure map(ApiException exception) {
    return switch (exception) {
      NetworkException() => const Failure.network(),
      TimeoutException() => const Failure.timeout(),
      HttpException() => _mapHttpException(exception),
      ParseException(:final details) => Failure.parsing(details: details),
      UnexpectedException(:final exception, :final stackTrace) =>
        Failure.unexpected(
          exception: exception,
          stackTrace: stackTrace,
        ),
    };
  }

  // ---------------------------------------------------------------------------
  // تحويل أخطاء HTTP بحسب كود الـ Status
  // ---------------------------------------------------------------------------
  static Failure _mapHttpException(HttpException e) {
    return switch (e.statusCode) {
      // --- 401: انتهت الجلسة أو Token غير صالح ---
      401 => UnauthorizedFailure(
          message: ApiErrorCodes.getMessage(
            e.errorCode,
            fallback: 'انتهت جلستك، يرجى تسجيل الدخول',
          ),
        ),

      // --- 403: لا يملك صلاحية ---
      403 => ForbiddenFailure(
          message: ApiErrorCodes.getMessage(
            e.errorCode,
            fallback: 'ليس لديك صلاحية للقيام بهذا الإجراء',
          ),
        ),

      // --- 404: المورد غير موجود ---
      404 => NotFoundFailure(
          message: ApiErrorCodes.getMessage(
            e.errorCode,
            fallback: 'البيانات المطلوبة غير موجودة',
          ),
        ),

      // --- 409: تعارض في البيانات ---
      409 => ConflictFailure(
          message: ApiErrorCodes.getMessage(
            e.errorCode,
            fallback: 'البيانات موجودة مسبقاً',
          ),
        ),

      // --- 422: أخطاء Validation --- يحمل تفاصيل الحقول
      422 => ValidationFailure(
          message: ApiErrorCodes.getMessage(
            e.errorCode,
            fallback: 'يوجد أخطاء في البيانات المدخلة',
          ),
          errors: e.validationErrors,
        ),

      // --- 503: الخدمة غير متاحة — قابلة للـ Retry ---
      503 => ServerFailure(
          message: ApiErrorCodes.getMessage(
            e.errorCode,
            fallback: 'الخدمة غير متاحة مؤقتاً',
          ),
          retryable: true, // 503 = مؤقت، يستحق إعادة المحاولة
        ),

      // --- 5xx: أخطاء الـ Server الأخرى ---
      >= 500 => ServerFailure(
          message: ApiErrorCodes.getMessage(
            e.errorCode,
            fallback: 'حدث خطأ في الخادم',
          ),
          errorCode: e.errorCode,
          retryable: false, // 5xx العام غير قابل للـ Retry افتراضياً
        ),

      // --- أي كود HTTP آخر ---
      _ => HttpErrorFailure(
          statusCode: e.statusCode,
          message: ApiErrorCodes.getMessage(
            e.errorCode,
            fallback: 'حدث خطأ غير متوقع (${e.statusCode})',
          ),
          errorCode: e.errorCode,
        ),
    };
  }
}
