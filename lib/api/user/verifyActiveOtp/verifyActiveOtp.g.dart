// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verifyActiveOtp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyActiveOtpApiStruct _$VerifyActiveOtpApiStructFromJson(
        Map<String, dynamic> json) =>
    VerifyActiveOtpApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$VerifyActiveOtpApiStructToJson(
        VerifyActiveOtpApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };
