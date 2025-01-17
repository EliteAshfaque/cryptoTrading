// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activityLogs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityLogsApiStruct _$ActivityLogsApiStructFromJson(
        Map<String, dynamic> json) =>
    ActivityLogsApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$ActivityLogsApiStructToJson(
        ActivityLogsApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

ActivityLogsStruct _$ActivityLogsStructFromJson(Map<String, dynamic> json) =>
    ActivityLogsStruct(
      uniqueId: json['uniqueId'] as String?,
      type: json['type'] as String?,
      email: json['email'] as String?,
      status: json['status'] as String?,
      createdAt: (json['createdAt'] as num?)?.toInt(),
      country: json['country'] as String?,
      city: json['city'] as String?,
      message: json['message'] as String?,
      browser: json['browser'] as String?,
      ip: json['ip'] as String?,
      lat: json['lat'] as String?,
      loginTime: (json['loginTime'] as num?)?.toInt(),
      long: json['long'] as String?,
      os: json['os'] as String?,
      timezone: json['timezone'] as String?,
    );

Map<String, dynamic> _$ActivityLogsStructToJson(ActivityLogsStruct instance) =>
    <String, dynamic>{
      'loginTime': instance.loginTime,
      'browser': instance.browser,
      'city': instance.city,
      'country': instance.country,
      'createdAt': instance.createdAt,
      'email': instance.email,
      'ip': instance.ip,
      'lat': instance.lat,
      'long': instance.long,
      'os': instance.os,
      'status': instance.status,
      'timezone': instance.timezone,
      'uniqueId': instance.uniqueId,
      'message': instance.message,
      'type': instance.type,
    };
