// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verifyAuth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyAuthApiStruct _$VerifyAuthApiStructFromJson(Map<String, dynamic> json) =>
    VerifyAuthApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$VerifyAuthApiStructToJson(
        VerifyAuthApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

VerifyAuthStruct _$VerifyAuthStructFromJson(Map<String, dynamic> json) =>
    VerifyAuthStruct(
      type: json['type'] as String?,
      data: json['data'],
    );

Map<String, dynamic> _$VerifyAuthStructToJson(VerifyAuthStruct instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
    };
