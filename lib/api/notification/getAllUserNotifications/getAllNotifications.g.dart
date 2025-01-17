// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getAllNotifications.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllNotificationsApiStruct _$GetAllNotificationsApiStructFromJson(
        Map<String, dynamic> json) =>
    GetAllNotificationsApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$GetAllNotificationsApiStructToJson(
        GetAllNotificationsApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

MobileNotificationsStruct _$MobileNotificationsStructFromJson(
        Map<String, dynamic> json) =>
    MobileNotificationsStruct(
      email: json['email'] as String?,
      body: json['body'] as String?,
      title: json['title'] as String?,
      createdAt: json['createdAt'] as String?,
      uniqueId: json['uniqueId'] as String?,
      updatedAt: json['updatedAt'] as String?,
      imageUrl: json['imageUrl'] as String?,
      opened: json['opened'] as bool?,
    )
      ..ip = json['ip'] as String?
      ..device = json['device'] as String?;

Map<String, dynamic> _$MobileNotificationsStructToJson(
        MobileNotificationsStruct instance) =>
    <String, dynamic>{
      'email': instance.email,
      'title': instance.title,
      'body': instance.body,
      'uniqueId': instance.uniqueId,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'opened': instance.opened,
      'ip': instance.ip,
      'device': instance.device,
    };
