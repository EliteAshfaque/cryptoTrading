// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'changePassword.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordApiStruct _$ChangePasswordApiStructFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$ChangePasswordApiStructToJson(
        ChangePasswordApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };
