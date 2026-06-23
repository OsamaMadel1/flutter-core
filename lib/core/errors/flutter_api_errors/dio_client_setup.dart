// =============================================================================
// dio_client_setup.dart
// =============================================================================
// إعداد Dio الكامل مع ربط ErrorInterceptor.
//
// هذا الملف يوضح:
//   - كيفية تهيئة Dio مع ErrorInterceptor
//   - Token Refresh مربوط بالـ Repository
//   - Timeout مناسب للـ Production
// =============================================================================

import 'package:dio/dio.dart';
import 'package:flutter_core/core/errors/flutter_api_errors/interceptors/error_interceptor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// [DioClientSetup] — يُنشئ Dio مُهيَّأ بالكامل
class DioClientSetup {
  static Dio create({
    required String baseUrl,
    required String? Function() getAccessToken,
    required Future<String?> Function() refreshToken,
    required void Function() onUnauthorized,
    bool enableLogging = true,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        // Timeout مناسب: لا قصير جداً (يُسبب false timeout) ولا طويل جداً
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // --- إضافة Token تلقائياً لكل طلب ---
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );

    // --- ErrorInterceptor — يجب أن يكون آخر Interceptor ---
    dio.interceptors.add(
      ErrorInterceptor(
        dio: dio,
        onTokenRefresh: refreshToken,
        onUnauthorized: onUnauthorized,
        enableLogging: enableLogging,
      ),
    );

    return dio;
  }
}

// =============================================================================
// Riverpod Provider للـ Dio
// =============================================================================

/// Provider للـ Dio — يُستخدم في كل Remote Data Sources
final dioProvider = Provider<Dio>((ref) {
  return DioClientSetup.create(
    baseUrl: 'https://api.your-government-app.com/v1',

    // استرجع الـ Token المحفوظ (SharedPreferences / SecureStorage)
    getAccessToken: () {
      // return ref.read(authTokenProvider);
      return null; // استبدل بالقيمة الحقيقية
    },

    // تجديد الـ Token
    refreshToken: () async {
      // return await ref.read(authRepositoryProvider).refreshToken();
      return null; // استبدل بالمنطق الحقيقي
    },

    // عند انتهاء الجلسة
    onUnauthorized: () {
      // ref.read(routerProvider).go('/login');
    },

    // أوقف الـ Logging في الإنتاج
    enableLogging: true, // const bool.fromEnvironment('DEBUG')
  );
});
