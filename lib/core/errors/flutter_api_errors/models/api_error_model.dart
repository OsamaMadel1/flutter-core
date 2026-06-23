// =============================================================================
// api_error_model.dart
// =============================================================================
// نموذج الخطأ المُستقبَل من الـ Backend عبر الـ HTTP Response Body.
//
// الـ Backend يُرسل JSON بهذا الشكل عند أي خطأ:
// {
//   "success": false,
//   "errorCode": "USER_NOT_FOUND",
//   "message": "User with id 42 not found",
//   "errors": {
//     "email": ["البريد الإلكتروني مستخدم مسبقاً"],
//     "phone": ["رقم الهاتف غير صالح"]
//   },
//   "timestamp": "2025-06-18T10:30:00Z"
// }
//
// ملاحظة: [errors] يُستخدم فقط مع أخطاء الـ Validation (422)
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error_model.freezed.dart';
part 'api_error_model.g.dart';

/// [ApiErrorModel] — تمثيل مباشر لـ Response Body عند الخطأ
@freezed
class ApiErrorModel with _$ApiErrorModel {
  const factory ApiErrorModel({
    /// هل العملية ناجحة؟ — دائماً false هنا
    @Default(false) bool success,

    /// كود الخطأ من الـ Backend (مثلاً "USER_NOT_FOUND")
    String? errorCode,

    /// رسالة تقنية من الـ Server (للـ Logging، لا للعرض المباشر)
    String? message,

    /// أخطاء التحقق: Map من اسم الحقل → قائمة الأخطاء
    /// { "email": ["مستخدم مسبقاً"], "password": ["قصيرة جداً"] }
    @Default({}) Map<String, List<String>> errors,

    /// طابع التوقيت للخطأ
    String? timestamp,
  }) = _ApiErrorModel;

  /// [fromJson] — لتحويل الـ JSON الواصل من الـ Backend
  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);
}

extension ApiErrorModelExtension on ApiErrorModel {
  /// هل توجد أخطاء validation تفصيلية؟
  bool get hasValidationErrors => errors.isNotEmpty;

  /// أول رسالة خطأ في أول حقل — مفيدة للـ Snackbar البسيط
  String? get firstValidationMessage {
    if (errors.isEmpty) return null;
    return errors.values.first.firstOrNull;
  }
}
