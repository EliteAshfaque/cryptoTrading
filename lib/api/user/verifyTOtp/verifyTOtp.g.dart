// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verifyTOtp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyTOtpApiStruct _$VerifyTOtpApiStructFromJson(Map<String, dynamic> json) =>
    VerifyTOtpApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$VerifyTOtpApiStructToJson(
        VerifyTOtpApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };
