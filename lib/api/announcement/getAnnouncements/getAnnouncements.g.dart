// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getAnnouncements.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAnnouncementApiStruct _$GetAnnouncementApiStructFromJson(
        Map<String, dynamic> json) =>
    GetAnnouncementApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$GetAnnouncementApiStructToJson(
        GetAnnouncementApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

AnnouncementStruct _$AnnouncementStructFromJson(Map<String, dynamic> json) =>
    AnnouncementStruct(
      title: json['title'] as String?,
      uniqueId: json['uniqueId'] as String?,
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$AnnouncementStructToJson(AnnouncementStruct instance) =>
    <String, dynamic>{
      'uniqueId': instance.uniqueId,
      'title': instance.title,
      'active': instance.active,
    };
