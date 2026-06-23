// =============================================================================
// base_repository.dart
// =============================================================================
// Repository الأساسي الذي يرث منه كل Repositories.
//
// يُغلّف كل منطق معالجة الأخطاء في مكان واحد:
//   - اعتراض ApiException
//   - تحويله إلى Failure عبر ErrorMapper
//   - دعم Retry عند الحاجة
//
// الاستخدام:
// ```dart
// class UserRepository extends BaseRepository {
//   Future<Result<List<UserModel>>> getUsers() {
//     return execute(() => _remoteDataSource.getUsers());
//   }
// }
// ```
// =============================================================================

import 'package:flutter_core/core/errors/flutter_api_errors/exceptions/api_exception.dart';
import 'package:flutter_core/core/errors/flutter_api_errors/mappers/error_mapper.dart';
import 'package:flutter_core/core/errors/flutter_api_errors/result/result.dart';
import 'package:flutter_core/core/errors/flutter_api_errors/retry/retry_helper.dart';

/// [BaseRepository] — أساس كل Repositories في المشروع
abstract base class BaseRepository {
  const BaseRepository();

  /// [execute] — ينفّذ عملية Data Source مع معالجة الأخطاء التلقائية
  ///
  /// - يعترض [ApiException] ويُحوّله إلى [Failure]
  /// - يعترض أي استثناء آخر ويُغلّفه في [UnexpectedFailure]
  ///
  /// ```dart
  /// Future<Result<UserModel>> getUser(int id) =>
  ///     execute(() => _remote.getUser(id));
  /// ```
  Future<Result<T>> execute<T>(
    Future<T> Function() operation,
  ) async {
    try {
      final data = await operation();
      return Result.success(data);
    } on ApiException catch (e) {
      // ApiException → Failure مُصنَّف
      final failure = ErrorMapper.map(e);
      return Result.failure(failure);
    } catch (e, stackTrace) {
      // أي استثناء آخر → UnexpectedFailure
      final failure = ErrorMapper.map(
        UnexpectedException(exception: e, stackTrace: stackTrace),
      );
      return Result.failure(failure);
    }
  }

  /// [executeWithRetry] — مثل [execute] لكن مع إعادة المحاولة للأخطاء المؤهلة
  ///
  /// ```dart
  /// Future<Result<List<UserModel>>> getUsers() =>
  ///     executeWithRetry(
  ///       () => _remote.getUsers(),
  ///       config: RetryConfig.standard,
  ///     );
  /// ```
  Future<Result<T>> executeWithRetry<T>(
    Future<T> Function() operation, {
    RetryConfig config = RetryConfig.standard,
    void Function(int attempt, dynamic failure)? onRetry,
  }) {
    return RetryHelper.execute(
      operation: () => execute(operation),
      config: config,
      onRetry: onRetry,
    );
  }
}
