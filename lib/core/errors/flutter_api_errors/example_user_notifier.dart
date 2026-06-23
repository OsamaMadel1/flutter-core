// =============================================================================
// example_user_notifier.dart
// =============================================================================
// مثال على Riverpod AsyncNotifier يوضح كيف يتعامل الـ UI مع النظام.
//
// يُظهر:
//   ✅ استخدام Result.fold
//   ✅ FailureHandler للحصول على ErrorState
//   ✅ التعامل مع Validation errors في الـ Form
//   ✅ إعادة المحاولة (Retry) من الـ UI
//   ✅ توجيه لـ Login عند UnauthorizedFailure
// =============================================================================
import 'export_errors.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_core/core/errors/flutter_api_errors/failures/failure.dart';
// import 'package:flutter_core/core/errors/flutter_api_errors/handlers/failure_handler.dart';
// import 'package:flutter_core/core/errors/flutter_api_errors/result/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'example_user_repository.dart';

// =============================================================================
// حالة الـ Notifier
// =============================================================================

/// [UsersState] — حالة شاشة المستخدمين
class UsersState {
  const UsersState({
    this.users = const [],
    this.isLoading = false,
    this.errorState,
  });

  final List<UserModel> users;
  final bool isLoading;

  /// إذا كانت null → لا يوجد خطأ
  final ErrorState? errorState;

  UsersState copyWith({
    List<UserModel>? users,
    bool? isLoading,
    ErrorState? errorState,
  }) {
    return UsersState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      errorState: errorState,
    );
  }
}

// =============================================================================
// Notifier
// =============================================================================

/// [UsersNotifier] — يُدير منطق شاشة المستخدمين
class UsersNotifier extends StateNotifier<UsersState> {
  UsersNotifier(this._repository) : super(const UsersState());

  final IUserRepository _repository;

  /// جلب المستخدمين
  Future<void> loadUsers() async {
    state = state.copyWith(isLoading: true);

    final result = await _repository.getUsers();

    state = result.fold(
      onFailure: (failure) {
        // FailureHandler يُحوّل Failure → ErrorState جاهز للـ UI
        final errorState = FailureHandler.handle(
          failure,
          onRetry: loadUsers, // زر "إعادة المحاولة" يُعيد الاستدعاء
        );
        return state.copyWith(isLoading: false, errorState: errorState);
      },
      onSuccess: (users) {
        return state.copyWith(isLoading: false, users: users);
      },
    );
  }

  /// إنشاء مستخدم — مع معالجة أخطاء الـ Validation
  Future<void> createUser({
    required String name,
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required Map<String, String> fieldErrors, // لعرض الأخطاء على الحقول
    required VoidCallback onSuccess,
  }) async {
    state = state.copyWith(isLoading: true);

    final result = await _repository.createUser(name);

    result.fold(
      onFailure: (failure) {
        final errorState = FailureHandler.handle(failure);

        // إذا كان Validation — ضع الأخطاء مباشرة على الحقول
        if (failure is ValidationFailure) {
          // تحديث الحقول بالأخطاء من الـ Server
          final serverErrors = errorState.validationErrors;
          if (serverErrors.containsKey('name')) {
            fieldErrors['name'] = errorState.fieldError('name') ?? '';
          }
          // أعِد بناء الـ Form ليظهر الخطأ
          formKey.currentState?.validate();
        } else {
          // عرض Snackbar أو Dialog حسب نوع الخطأ
          _showError(context, errorState);
        }

        state = state.copyWith(isLoading: false, errorState: errorState);
      },
      onSuccess: (_) {
        state = state.copyWith(isLoading: false);
        onSuccess();
        loadUsers(); // أعِد تحميل القائمة
      },
    );
  }

  // ---------------------------------------------------------------------------
  // عرض الخطأ في الـ UI حسب نوعه
  // ---------------------------------------------------------------------------
  void _showError(BuildContext context, ErrorState errorState) {
    switch (errorState.displayType) {
      case ErrorDisplayType.snackbar:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorState.message),
            backgroundColor: Colors.red,
            action: errorState.actionLabel != null
                ? SnackBarAction(
                    label: errorState.actionLabel!,
                    onPressed: errorState.onAction ?? () {},
                  )
                : null,
          ),
        );

      case ErrorDisplayType.dialog:
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('خطأ'),
            content: Text(errorState.message),
            actions: [
              if (errorState.actionLabel != null)
                TextButton(
                  onPressed: errorState.onAction,
                  child: Text(errorState.actionLabel!),
                ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('إغلاق'),
              ),
            ],
          ),
        );

      case ErrorDisplayType.fullScreen:
        // وجّه لشاشة خطأ كاملة
        // context.go('/error', extra: errorState);
        break;

      case ErrorDisplayType.inline:
        // الـ Inline errors تُعالج مباشرة في الـ Form
        break;
    }
  }
}

// =============================================================================
// Providers
// =============================================================================

/// Provider للـ Repository — في المشروع الحقيقي يأتي من DI
final userRepositoryProvider = Provider<IUserRepository>((ref) {
  // return UserRepository(remoteDataSource: ref.watch(userRemoteDataSourceProvider));
  throw UnimplementedError('يجب تهيئة UserRepository');
});

/// Provider للـ Notifier
final usersNotifierProvider = StateNotifierProvider<UsersNotifier, UsersState>((
  ref,
) {
  return UsersNotifier(ref.watch(userRepositoryProvider));
});
