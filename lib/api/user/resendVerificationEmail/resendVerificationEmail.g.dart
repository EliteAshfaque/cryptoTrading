// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resendVerificationEmail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResendVerificationEmailApiStruct _$ResendVerificationEmailApiStructFromJson(
        Map<String, dynamic> json) =>
    ResendVerificationEmailApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$ResendVerificationEmailApiStructToJson(
        ResendVerificationEmailApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };
