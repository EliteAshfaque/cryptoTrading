// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'updateNotification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateNotificationsApiStruct _$UpdateNotificationsApiStructFromJson(
        Map<String, dynamic> json) =>
    UpdateNotificationsApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$UpdateNotificationsApiStructToJson(
        UpdateNotificationsApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };
