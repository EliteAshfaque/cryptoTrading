// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submitKyc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitKycApiStruct _$SubmitKycApiStructFromJson(Map<String, dynamic> json) =>
    SubmitKycApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$SubmitKycApiStructToJson(SubmitKycApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };
