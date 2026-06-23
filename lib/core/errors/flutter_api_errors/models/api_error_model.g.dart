// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiErrorModelImpl _$$ApiErrorModelImplFromJson(Map<String, dynamic> json) =>
    _$ApiErrorModelImpl(
      success: json['success'] as bool? ?? false,
      errorCode: json['errorCode'] as String?,
      message: json['message'] as String?,
      errors:
          (json['errors'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
              k,
              (e as List<dynamic>).map((e) => e as String).toList(),
            ),
          ) ??
          const {},
      timestamp: json['timestamp'] as String?,
    );

Map<String, dynamic> _$$ApiErrorModelImplToJson(_$ApiErrorModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'errorCode': instance.errorCode,
      'message': instance.message,
      'errors': instance.errors,
      'timestamp': instance.timestamp,
    };
