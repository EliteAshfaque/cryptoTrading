// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RecentPinActivityData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentPinActivityData _$RecentPinActivityDataFromJson(
        Map<String, dynamic> json) =>
    RecentPinActivityData(
      userID: (json['userID'] as num?)?.toInt(),
      ip: json['ip'] as String?,
      lastLoginIP: json['lastLoginIP'] as String?,
      entryDate: json['entryDate'] as String?,
      lastLoginDate: json['lastLoginDate'] as String?,
    );

Map<String, dynamic> _$RecentPinActivityDataToJson(
        RecentPinActivityData instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'ip': instance.ip,
      'lastLoginIP': instance.lastLoginIP,
      'entryDate': instance.entryDate,
      'lastLoginDate': instance.lastLoginDate,
    };
