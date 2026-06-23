// =============================================================================
// api_exception.dart
// =============================================================================
// استثناءات مخصصة تُرمى من Data Layer وتُترجم في Error Mapper.
//
// التدفق:
//   Dio Exception / HTTP Error
//       ↓
//   [ApiException]  ← يُرمى هنا
//       ↓
//   [ErrorMapper]   ← يُترجَم هنا
//       ↓
//   [Failure]       ← يصل للـ Repository والـ UI
//
// لماذا ApiException بدلاً من Failure مباشرة؟
// → لأن Exceptions تُرمى من Data Layer (Remote Data Source)
//   بينما Failure يُعاد من Repository
// → الفصل يُسهّل الـ Testing والـ Logging
// =============================================================================

/// [ApiException] — Base class لجميع استثناءات الـ API
sealed class ApiException implements Exception {
  const ApiException();
}
// =============================================================================
// أنواع الاستثناءات
// =============================================================================

/// استثناء شبكة — لا يوجد اتصال أو فشل DNS
class NetworkException extends ApiException {
  const NetworkException({this.details});

  /// تفاصيل تقنية للـ Logging (لا تُعرض للمستخدم)
  final String? details;

  @override
  String toString() => 'NetworkException: ${details ?? 'No connection'}';
}

/// انتهت مهلة الطلب
class TimeoutException extends ApiException {
  const TimeoutException({this.durationMs});

  /// المدة الزمنية التي انتهت قبل الرد (بالميلي ثانية)
  final int? durationMs;

  @override
  String toString() => 'TimeoutException: ${durationMs}ms';
}

/// استثناء HTTP — كود الـ Status بين 400 و 599
class HttpException extends ApiException {
  const HttpException({
    required this.statusCode,
    this.errorCode,
    this.message,
    this.validationErrors = const {},
    this.rawBody,
  });

  /// كود HTTP (401, 403, 404, 422, 500...)
  final int statusCode;

  /// كود الأخطاء من الـ Backend (مثلاً "USER_NOT_FOUND")
  final String? errorCode;

  /// رسالة الخطأ من الـ Backend
  final String? message;

  /// أخطاء الـ Validation (للـ 422 فقط)
  final Map<String, List<String>> validationErrors;

  /// الـ Body الخام للـ Response — للـ Logging
  final String? rawBody;

  /// هل هذا خطأ غير مصرح؟ (401)
  bool get isUnauthorized => statusCode == 401;

  /// هل هذا خطأ محظور؟ (403)
  bool get isForbidden => statusCode == 403;

  /// هل هذا خطأ Validation؟ (422)
  bool get isValidation => statusCode == 422;

  /// هل هذا خطأ Server؟ (5xx)
  bool get isServerError => statusCode >= 500;

  @override
  String toString() =>
      'HttpException[$statusCode]: $errorCode - $message';
}

/// فشل تحليل الـ JSON — تنسيق غير متوقع في الـ Response
class ParseException extends ApiException {
  const ParseException({
    required this.details,
    this.rawBody,
  });

  /// وصف المشكلة (مثلاً "field 'id' expected int got string")
  final String details;

  /// الـ Body الخام للـ Response — للـ Logging
  final String? rawBody;

  @override
  String toString() => 'ParseException: $details';
}

/// استثناء غير متوقع — أي Exception لم يُتوقع
class UnexpectedException extends ApiException {
  const UnexpectedException({
    required this.exception,
    this.stackTrace,
  });

  final Object exception;
  final StackTrace? stackTrace;

  @override
  String toString() => 'UnexpectedException: $exception';
}
