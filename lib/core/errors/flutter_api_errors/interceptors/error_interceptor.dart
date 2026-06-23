// =============================================================================
// error_interceptor.dart
// =============================================================================
// Dio Interceptor — يعترض كل Response ويُحوّل أخطاء HTTP إلى ApiException.
//
// التدفق:
//   Dio Request
//       ↓
//   [ErrorInterceptor.onError]
//       ↓
//   يُحلّل نوع الخطأ:
//     - DioExceptionType.connectionError → NetworkException
//     - DioExceptionType.connectionTimeout → TimeoutException
//     - Response Error (4xx/5xx) → HttpException
//       ↓
//   يُرمى ApiException
//       ↓
//   Repository يُمسكه ويُحوّله إلى Failure
//
// يتضمن أيضاً:
//   - Token Refresh عند 401 (إعادة المحاولة بـ Token جديد)
//   - Logging للأخطاء
// =============================================================================

import 'dart:convert';
import 'package:dio/dio.dart';
import '../exceptions/api_exception.dart';
import '../models/api_error_model.dart';

/// [ErrorInterceptor] — Dio Interceptor رئيسي لمعالجة الأخطاء
class ErrorInterceptor extends Interceptor {
  ErrorInterceptor({
    required this.dio,
    this.onTokenRefresh,
    this.onUnauthorized,
    this.enableLogging = true,
  });

  /// نفس Dio instance — لإعادة الطلب بعد Refresh
  final Dio dio;

  /// Callback لتجديد الـ Token — يُعيد Token الجديد أو null إذا فشل
  final Future<String?> Function()? onTokenRefresh;

  /// Callback عند فشل الـ Refresh — عادةً يوجّه لشاشة Login
  final VoidCallback? onUnauthorized;

  /// هل يُفعّل سجل الأخطاء في console؟
  final bool enableLogging;

  /// مؤقت لمنع Refresh المتكرر (loop)
  bool _isRefreshing = false;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    _log('❌ [${err.requestOptions.method}] ${err.requestOptions.path}');

    // --------------------------------------------------------------------------
    // تصنيف نوع خطأ Dio
    // --------------------------------------------------------------------------
    switch (err.type) {
      // لا يوجد اتصال بالإنترنت أو فشل DNS
      case DioExceptionType.connectionError:
        return handler.reject(_toDioError(err, const NetworkException()));

      // انتهت مهلة الاتصال
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return handler.reject(
          _toDioError(
            err,
            TimeoutException(
              durationMs: err.requestOptions.connectTimeout?.inMilliseconds,
            ),
          ),
        );

      // خطأ في الـ Response (4xx / 5xx)
      case DioExceptionType.badResponse:
        final response = err.response;
        if (response == null) {
          return handler.reject(
            _toDioError(err, const NetworkException(details: 'No response')),
          );
        }

        // --- 401: حاول تجديد الـ Token قبل الرفض ---
        if (response.statusCode == 401 && !_isRefreshing) {
          final refreshed = await _tryRefreshToken(err, handler);
          if (refreshed) return; // تم إعادة الطلب بنجاح
        }

        return handler.reject(_toDioError(err, _parseHttpException(response)));

      // أي خطأ Dio آخر
      default:
        return handler.reject(
          _toDioError(err, UnexpectedException(exception: err.error ?? err)),
        );
    }
  }

  // ---------------------------------------------------------------------------
  // تحليل Body الـ Response وإنشاء HttpException مناسب
  // ---------------------------------------------------------------------------
  HttpException _parseHttpException(Response response) {
    final statusCode = response.statusCode ?? 0;
    String? errorCode;
    String? message;
    Map<String, List<String>> validationErrors = {};
    String? rawBody;

    try {
      final data = response.data;

      // تحويل String → Map إذا لزم
      final Map<String, dynamic> json = switch (data) {
        Map<String, dynamic>() => data,
        String() when data.isNotEmpty => jsonDecode(data),
        _ => {},
      };

      rawBody = data is String ? data : jsonEncode(data);

      // تحليل ApiErrorModel من الـ JSON
      if (json.isNotEmpty) {
        final errorModel = ApiErrorModel.fromJson(json);
        errorCode = errorModel.errorCode;
        message = errorModel.message;

        // أخطاء الـ Validation (422)
        if (statusCode == 422) {
          validationErrors = errorModel.errors;
        }
      }
    } catch (e) {
      _log('⚠️ Failed to parse error body: $e');
    }

    return HttpException(
      statusCode: statusCode,
      errorCode: errorCode,
      message: message,
      validationErrors: validationErrors,
      rawBody: rawBody,
    );
  }

  // ---------------------------------------------------------------------------
  // Token Refresh — يحاول تجديد الـ Token وإعادة الطلب الأصلي
  // ---------------------------------------------------------------------------
  Future<bool> _tryRefreshToken(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (onTokenRefresh == null) return false;

    _isRefreshing = true;
    _log('🔄 Attempting token refresh...');

    try {
      final newToken = await onTokenRefresh!();

      if (newToken == null) {
        // فشل الـ Refresh — وجّه للـ Login
        _log('❌ Token refresh failed — redirecting to login');
        onUnauthorized?.call();
        return false;
      }

      _log('✅ Token refreshed successfully');

      // أعِد الطلب الأصلي بالـ Token الجديد
      final options = err.requestOptions;
      options.headers['Authorization'] = 'Bearer $newToken';

      final response = await dio.fetch(options);
      handler.resolve(response);
      return true;
    } catch (e) {
      _log('❌ Token refresh exception: $e');
      onUnauthorized?.call();
      return false;
    } finally {
      _isRefreshing = false;
    }
  }

  // ---------------------------------------------------------------------------
  // مساعدات داخلية
  // ---------------------------------------------------------------------------

  /// تحويل ApiException → DioException لمتابعة Dio Pipeline
  DioException _toDioError(DioException original, ApiException apiException) {
    return DioException(
      requestOptions: original.requestOptions,
      response: original.response,
      error: apiException, // يُخزَّن هنا ليُمسك في Repository
      type: original.type,
    );
  }

  void _log(String message) {
    if (enableLogging) {
      // ignore: avoid_print
      print('[ErrorInterceptor] $message');
    }
  }
}

/// Placeholder — استبدل بـ VoidCallback الصحيح من Flutter
typedef VoidCallback = void Function();
