// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Banners.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Banners _$BannersFromJson(Map<String, dynamic> json) => Banners(
      resourceUrl: json['resourceUrl'] as String?,
      siteResourceUrl: json['siteResourceUrl'] as String?,
      siteFileName: json['siteFileName'] as String?,
      popupResourceUrl: json['popupResourceUrl'] as String?,
      popupFileName: json['popupFileName'] as String?,
      fileName: json['fileName'] as String?,
    );

Map<String, dynamic> _$BannersToJson(Banners instance) => <String, dynamic>{
      'resourceUrl': instance.resourceUrl,
      'siteResourceUrl': instance.siteResourceUrl,
      'siteFileName': instance.siteFileName,
      'popupResourceUrl': instance.popupResourceUrl,
      'popupFileName': instance.popupFileName,
      'fileName': instance.fileName,
    };
