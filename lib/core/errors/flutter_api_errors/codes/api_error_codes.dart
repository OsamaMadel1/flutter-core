// =============================================================================
// api_error_codes.dart
// =============================================================================
// كودات الأخطاء المعرَّفة من الـ Backend.
//
// المبدأ: الـ Backend يُرسل كوداً نصياً مع كل خطأ business logic،
// مثل "USER_NOT_FOUND" أو "LICENSE_EXPIRED"، وهنا نُترجمها لرسائل عربية.
//
// الفائدة:
// - رسائل الأخطاء تُدار من Flutter بدلاً من الاعتماد على نص الـ Server
// - سهولة التعريب والتحديث
// - اتساق التجربة عبر الـ App
//
// كيفية الاستخدام:
//   ApiErrorCodes.getMessage('USER_NOT_FOUND')  → 'المستخدم غير موجود'
// =============================================================================

/// [ApiErrorCodes] — جميع كودات الأخطاء المتوقعة من الـ Backend
abstract final class ApiErrorCodes {
  // ---------------------------------------------------------------------------
  // 👤 أخطاء المستخدمين
  // ---------------------------------------------------------------------------
  static const String userNotFound = 'USER_NOT_FOUND';
  static const String userAlreadyExists = 'USER_ALREADY_EXISTS';
  static const String userInactive = 'USER_INACTIVE';
  static const String userBlocked = 'USER_BLOCKED';

  // ---------------------------------------------------------------------------
  // 🔐 أخطاء المصادقة
  // ---------------------------------------------------------------------------
  static const String invalidCredentials = 'INVALID_CREDENTIALS';
  static const String tokenExpired = 'TOKEN_EXPIRED';
  static const String tokenInvalid = 'TOKEN_INVALID';
  static const String refreshTokenExpired = 'REFRESH_TOKEN_EXPIRED';
  static const String tooManyLoginAttempts = 'TOO_MANY_LOGIN_ATTEMPTS';

  // ---------------------------------------------------------------------------
  // 📱 أخطاء الترخيص (مخصصة للمشروع الحكومي)
  // ---------------------------------------------------------------------------
  static const String licenseNotFound = 'LICENSE_NOT_FOUND';
  static const String licenseExpired = 'LICENSE_EXPIRED';
  static const String licenseInvalid = 'LICENSE_INVALID';
  static const String deviceNotBound = 'DEVICE_NOT_BOUND';
  static const String deviceMismatch = 'DEVICE_MISMATCH';
  static const String transferPending = 'TRANSFER_PENDING';
  static const String transferNotAllowed = 'TRANSFER_NOT_ALLOWED';
  static const String locationAnomaly = 'LOCATION_ANOMALY';

  // ---------------------------------------------------------------------------
  // 🗄️ أخطاء البيانات
  // ---------------------------------------------------------------------------
  static const String validationError = 'VALIDATION_ERROR';
  static const String duplicateEntry = 'DUPLICATE_ENTRY';
  static const String resourceNotFound = 'RESOURCE_NOT_FOUND';
  static const String foreignKeyViolation = 'FOREIGN_KEY_VIOLATION';

  // ---------------------------------------------------------------------------
  // 🖥️ أخطاء الـ Server
  // ---------------------------------------------------------------------------
  static const String internalServerError = 'INTERNAL_SERVER_ERROR';
  static const String serviceUnavailable = 'SERVICE_UNAVAILABLE';
  static const String maintenanceMode = 'MAINTENANCE_MODE';

  // ---------------------------------------------------------------------------
  // خريطة الترجمة: code → رسالة عربية للمستخدم
  // ---------------------------------------------------------------------------
  static const Map<String, String> _messages = {
    // المستخدمون
    userNotFound: 'المستخدم غير موجود',
    userAlreadyExists: 'هذا المستخدم مسجل مسبقاً',
    userInactive: 'الحساب غير مفعّل، يرجى التواصل مع الإدارة',
    userBlocked: 'تم حظر هذا الحساب',

    // المصادقة
    invalidCredentials: 'اسم المستخدم أو كلمة المرور غير صحيحة',
    tokenExpired: 'انتهت جلستك، يرجى تسجيل الدخول',
    tokenInvalid: 'جلسة غير صالحة، يرجى إعادة تسجيل الدخول',
    refreshTokenExpired: 'انتهت جلستك، يرجى تسجيل الدخول مجدداً',
    tooManyLoginAttempts: 'تجاوزت عدد محاولات تسجيل الدخول المسموحة',

    // الترخيص
    licenseNotFound: 'لا يوجد ترخيص مرتبط بهذا الجهاز',
    licenseExpired: 'انتهت صلاحية الترخيص',
    licenseInvalid: 'رمز الترخيص غير صالح',
    deviceNotBound: 'هذا الجهاز غير مرتبط بأي ترخيص',
    deviceMismatch: 'لا يتطابق هذا الجهاز مع الترخيص المسجل',
    transferPending: 'طلب النقل قيد الانتظار، يرجى الانتظار حتى الموافقة',
    transferNotAllowed: 'نقل الترخيص غير مسموح في الوقت الحالي',
    locationAnomaly: 'تم رصد موقع غير معتاد، يرجى التحقق من هويتك',

    // البيانات
    validationError: 'البيانات المدخلة غير صحيحة',
    duplicateEntry: 'البيانات موجودة مسبقاً',
    resourceNotFound: 'المورد المطلوب غير موجود',
    foreignKeyViolation: 'لا يمكن حذف هذا العنصر لارتباطه ببيانات أخرى',

    // الـ Server
    internalServerError: 'حدث خطأ داخلي في الخادم',
    serviceUnavailable: 'الخدمة غير متاحة مؤقتاً',
    maintenanceMode: 'النظام في وضع الصيانة، يرجى المحاولة لاحقاً',
  };

  /// استرجع الرسالة العربية للكود المُعطى.
  /// إذا لم يُعرَّف الكود → رسالة افتراضية.
  static String getMessage(String? code, {String? fallback}) {
    if (code == null) return fallback ?? 'حدث خطأ غير متوقع';
    return _messages[code] ?? fallback ?? 'حدث خطأ: $code';
  }

  /// هل هذا الكود يتطلب تسجيل الدخول مجدداً؟
  static bool requiresReauth(String? code) => {
        tokenExpired,
        tokenInvalid,
        refreshTokenExpired,
      }.contains(code);

  /// هل هذا الكود خاص بالترخيص؟
  static bool isLicenseError(String? code) => {
        licenseNotFound,
        licenseExpired,
        licenseInvalid,
        deviceNotBound,
        deviceMismatch,
      }.contains(code);
}
