// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resetPass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPassApiStruct _$ResetPassApiStructFromJson(Map<String, dynamic> json) =>
    ResetPassApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$ResetPassApiStructToJson(ResetPassApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };