// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sendActiveOtp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendActiveOtpApiStruct _$SendActiveOtpApiStructFromJson(
        Map<String, dynamic> json) =>
    SendActiveOtpApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$SendActiveOtpApiStructToJson(
        SendActiveOtpApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };
