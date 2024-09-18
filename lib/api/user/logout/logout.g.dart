// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogOutApiStruct _$LogOutApiStructFromJson(Map<String, dynamic> json) =>
    LogOutApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$LogOutApiStructToJson(LogOutApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };
