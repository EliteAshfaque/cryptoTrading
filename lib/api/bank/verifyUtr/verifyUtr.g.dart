// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verifyUtr.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyUtrApiStruct _$VerifyUtrApiStructFromJson(Map<String, dynamic> json) =>
    VerifyUtrApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$VerifyUtrApiStructToJson(VerifyUtrApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };
