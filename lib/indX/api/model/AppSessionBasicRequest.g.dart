// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppSessionBasicRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppSessionBasicRequest _$AppSessionBasicRequestFromJson(
        Map<String, dynamic> json) =>
    AppSessionBasicRequest(
      appSession: json['appSession'] == null
          ? null
          : BasicRequest.fromJson(json['appSession'] as Map<String, dynamic>),
      request: json['Request'],
    );

Map<String, dynamic> _$AppSessionBasicRequestToJson(
        AppSessionBasicRequest instance) =>
    <String, dynamic>{
      'appSession': instance.appSession,
      'Request': instance.request,
    };
