// =============================================================================
// example_user_repository.dart
// =============================================================================
// مثال كامل على Repository حقيقي يوضح التدفق الكامل للنظام.
//
// يُظهر:
//   ✅ استخدام BaseRepository
//   ✅ execute() للعمليات العادية
//   ✅ executeWithRetry() للعمليات الحساسة
//   ✅ Result<T> كـ Return Type
// =============================================================================

import 'package:flutter_core/core/errors/flutter_api_errors/base_repository.dart';
import 'package:flutter_core/core/errors/flutter_api_errors/result/result.dart';
import 'package:flutter_core/core/errors/flutter_api_errors/retry/retry_helper.dart';



// ---------------------------------------------------------------------------
// نماذج وهمية للمثال
// ---------------------------------------------------------------------------


class UserModel {
  const UserModel({required this.id, required this.name});
  final int id;
  final String name;
}

/// Remote Data Source الوهمي — في الواقع يستخدم Dio
abstract interface class IUserRemoteDataSource {
  Future<List<UserModel>> getUsers();
  Future<UserModel> getUserById(int id);
  Future<UserModel> createUser(String name);
  Future<void> deleteUser(int id);
}

// ---------------------------------------------------------------------------
// Repository Interface
// ---------------------------------------------------------------------------
abstract interface class IUserRepository {
  Future<Result<List<UserModel>>> getUsers();
  Future<Result<UserModel>> getUserById(int id);
  Future<Result<UserModel>> createUser(String name);
  Future<Result<void>> deleteUser(int id);
}

// ---------------------------------------------------------------------------
// Repository Implementation
// ---------------------------------------------------------------------------

/// [UserRepository] — مثال كامل على Repository مع نظام الأخطاء
final class UserRepository extends BaseRepository implements IUserRepository {
  const UserRepository({required IUserRemoteDataSource remoteDataSource})
      : _remote = remoteDataSource;

  final IUserRemoteDataSource _remote;

  /// جلب قائمة المستخدمين مع إعادة المحاولة
  /// — قابل للـ Retry لأنه قراءة بيانات (GET)
  @override
  Future<Result<List<UserModel>>> getUsers() {
    return executeWithRetry(
      () => _remote.getUsers(),
      config: RetryConfig.standard,
    );
  }

  /// جلب مستخدم بالـ ID
  /// — بدون Retry لأنه طلب محدد (404 لا يستحق retry)
  @override
  Future<Result<UserModel>> getUserById(int id) {
    return execute(() => _remote.getUserById(id));
  }

  /// إنشاء مستخدم جديد
  /// — بدون Retry لأنه POST (قد يتكرر)
  @override
  Future<Result<UserModel>> createUser(String name) {
    return execute(() => _remote.createUser(name));
  }

  /// حذف مستخدم
  /// — بدون Retry لأنه DELETE (خطير التكرار)
  @override
  Future<Result<void>> deleteUser(int id) {
    return execute(() => _remote.deleteUser(id));
  }
}
