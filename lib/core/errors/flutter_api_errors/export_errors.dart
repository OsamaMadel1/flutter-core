// =============================================================================
// errors.dart — Barrel Export
// =============================================================================
// استيراد واحد يُغطي نظام الأخطاء بالكامل.
//
// في أي Repository أو Notifier:
//   import 'package:your_app/core/errors/errors.dart';
// =============================================================================

// Result
export 'result/result.dart';

// Failures
export 'failures/failure.dart';

// Exceptions
export 'exceptions/api_exception.dart';

// Models
export 'models/api_error_model.dart';

// Codes
export 'codes/api_error_codes.dart';

// Mappers
export 'mappers/error_mapper.dart';

// Handlers
export 'handlers/failure_handler.dart';

// Interceptors
export 'interceptors/error_interceptor.dart';

// Retry
export 'retry/retry_helper.dart';

// Base Repository
export 'base_repository.dart';
