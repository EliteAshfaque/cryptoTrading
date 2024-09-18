// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getBanner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBannerApiStruct _$GetBannerApiStructFromJson(Map<String, dynamic> json) =>
    GetBannerApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$GetBannerApiStructToJson(GetBannerApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

BannerStruct _$BannerStructFromJson(Map<String, dynamic> json) => BannerStruct(
      uniqueId: json['uniqueId'] as String?,
      createdAt: json['createdAt'] as String?,
      title: json['title'] as String?,
      updatedAt: json['updatedAt'] as String?,
      action: json['action'] as String?,
      imgUrl: json['imgUrl'] as String?,
    );

Map<String, dynamic> _$BannerStructToJson(BannerStruct instance) =>
    <String, dynamic>{
      'uniqueId': instance.uniqueId,
      'title': instance.title,
      'action': instance.action,
      'imgUrl': instance.imgUrl,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
