// =============================================================================
// retry_helper.dart
// =============================================================================
// نظام إعادة المحاولة الذكي.
//
// التحسين الرئيسي عن الـ Retry البسيط:
//   ✅ يُفرّق بين أخطاء قابلة للـ Retry وغير قابلة
//   ✅ Exponential Backoff — يزداد وقت الانتظار تدريجياً
//   ✅ Jitter — عشوائية بسيطة لتفادي "thundering herd"
//   ✅ Max Attempts قابل للتخصيص
//
// أخطاء قابلة للـ Retry:     Network, Timeout, 503
// أخطاء غير قابلة للـ Retry: 400, 401, 403, 404, 422
// =============================================================================

import 'dart:math';
import '../exceptions/api_exception.dart';
import '../failures/failure.dart';
import '../result/result.dart';

/// [RetryConfig] — إعدادات الـ Retry
class RetryConfig {
  const RetryConfig({
    this.maxAttempts = 3,
    this.initialDelay = const Duration(seconds: 1),
    this.maxDelay = const Duration(seconds: 10),
    this.useExponentialBackoff = true,
    this.useJitter = true,
  });

  /// الحد الأقصى لعدد المحاولات (بما فيها الأولى)
  final int maxAttempts;

  /// وقت الانتظار قبل أول إعادة محاولة
  final Duration initialDelay;

  /// الحد الأقصى لوقت الانتظار (لمنع الانتظار الطويل جداً)
  final Duration maxDelay;

  /// هل يُضاعف وقت الانتظار بعد كل محاولة؟
  final bool useExponentialBackoff;

  /// إضافة عشوائية ±20% لتفادي التزاحم
  final bool useJitter;

  /// إعداد افتراضي خفيف — للطلبات السريعة
  static const light = RetryConfig(maxAttempts: 2, initialDelay: Duration(milliseconds: 500));

  /// إعداد افتراضي معتدل — للطلبات العادية
  static const standard = RetryConfig(maxAttempts: 3, initialDelay: Duration(seconds: 1));

  /// إعداد قوي — للعمليات الحرجة
  static const aggressive = RetryConfig(maxAttempts: 5, initialDelay: Duration(seconds: 2));
}

/// [RetryHelper] — ينفّذ الـ Operation مع إعادة المحاولة عند الفشل المناسب
abstract final class RetryHelper {
  /// ينفّذ [operation] مع إعادة المحاولة وفق [config].
  ///
  /// مثال:
  /// ```dart
  /// final result = await RetryHelper.execute(
  ///   operation: () => remoteDataSource.getUsers(),
  ///   config: RetryConfig.standard,
  /// );
  /// ```
  static Future<Result<T>> execute<T>({
    required Future<Result<T>> Function() operation,
    RetryConfig config = RetryConfig.standard,
    void Function(int attempt, Failure failure)? onRetry,
  }) async {
    int attempts = 0;

    while (true) {
      attempts++;

      final result = await operation();

      // نجاح — أعِد النتيجة فوراً
      if (result.isSuccess) return result;

      final failure = result.failureOrNull!;

      // فشل غير قابل للـ Retry — أعِد الفشل فوراً بدون انتظار
      if (!failure.isRetryable) {
        return result;
      }

      // وصلنا للحد الأقصى — أعِد آخر فشل
      if (attempts >= config.maxAttempts) {
        return result;
      }

      // احسب وقت الانتظار قبل المحاولة التالية
      final delay = _calculateDelay(attempts, config);

      onRetry?.call(attempts, failure);
      // ignore: avoid_print
      print('[RetryHelper] Attempt $attempts failed (${failure.displayMessage}). Retrying in ${delay.inMilliseconds}ms...');

      await Future.delayed(delay);
    }
  }

  /// ينفّذ [operation] مع Retry — نسخة مخصصة لـ ApiException مباشرة
  ///
  /// مفيدة عند استخدامه في Data Sources قبل الـ Mapper
  static Future<T> executeRaw<T>({
    required Future<T> Function() operation,
    RetryConfig config = RetryConfig.standard,
  }) async {
    int attempts = 0;
    Object? lastException;

    while (attempts < config.maxAttempts) {
      attempts++;
      try {
        return await operation();
      } on ApiException catch (e) {
        lastException = e;

        // لا تُعيد المحاولة إذا كان الخطأ غير قابل لها
        if (!_isRetryableException(e) || attempts >= config.maxAttempts) {
          rethrow;
        }

        final delay = _calculateDelay(attempts, config);
        await Future.delayed(delay);
      }
    }

    throw lastException!;
  }

  // ---------------------------------------------------------------------------
  // مساعدات داخلية
  // ---------------------------------------------------------------------------

  /// حساب وقت الانتظار مع Exponential Backoff و Jitter
  static Duration _calculateDelay(int attempt, RetryConfig config) {
    Duration delay;

    if (config.useExponentialBackoff) {
      // وقت الانتظار = initialDelay × 2^(attempt-1)
      // المحاولة 1 → 1s, المحاولة 2 → 2s, المحاولة 3 → 4s
      final multiplier = pow(2, attempt - 1).toInt();
      delay = Duration(
        milliseconds: (config.initialDelay.inMilliseconds * multiplier)
            .clamp(0, config.maxDelay.inMilliseconds),
      );
    } else {
      delay = config.initialDelay;
    }

    // إضافة Jitter ±20% لتفادي التزاحم
    if (config.useJitter) {
      final jitterRange = delay.inMilliseconds * 0.2;
      final jitter = (Random().nextDouble() * jitterRange * 2) - jitterRange;
      delay = Duration(milliseconds: (delay.inMilliseconds + jitter).round());
    }

    return delay;
  }

  /// هل هذا الـ ApiException قابل للـ Retry؟
  static bool _isRetryableException(ApiException exception) {
    return switch (exception) {
      NetworkException() => true,  // لا يوجد اتصال → انتظر وأعِد
      TimeoutException() => true,  // Timeout → انتظر وأعِد
      HttpException(:final statusCode) => statusCode == 503, // خدمة مؤقتة
      _ => false,
    };
  }
}
