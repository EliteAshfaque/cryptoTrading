// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LogoutRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogoutRequest _$LogoutRequestFromJson(Map<String, dynamic> json) =>
    LogoutRequest(
      json['sessType'] as String?,
      (json['loginTypeID'] as num?)?.toInt(),
      (json['userID'] as num?)?.toInt(),
      json['session'] as String?,
      (json['sessionID'] as num?)?.toInt(),
      json['appid'] as String?,
      json['imei'] as String?,
      json['regKey'] as String?,
      json['version'] as String?,
      json['serialNo'] as String?,
    )..isSeller = json['isSeller'] as bool?;

Map<String, dynamic> _$LogoutRequestToJson(LogoutRequest instance) =>
    <String, dynamic>{
      'loginTypeID': instance.loginTypeID,
      'userID': instance.userID,
      'session': instance.session,
      'sessionID': instance.sessionID,
      'appid': instance.appid,
      'imei': instance.imei,
      'regKey': instance.regKey,
      'version': instance.version,
      'serialNo': instance.serialNo,
      'isSeller': instance.isSeller,
      'sessType': instance.sessType,
    };
