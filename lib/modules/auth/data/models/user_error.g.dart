// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserError _$UserErrorFromJson(Map<String, dynamic> json) => UserError(
      errorDescription: json['error_description'] as String,
      errorCode: json['errorCode'] as String,
      error: json['error'] as String,
    );

Map<String, dynamic> _$UserErrorToJson(UserError instance) => <String, dynamic>{
      'error_description': instance.errorDescription,
      'errorCode': instance.errorCode,
      'error': instance.error,
    };
