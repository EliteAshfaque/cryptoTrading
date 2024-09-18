// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OTPResendRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTPResendRequest _$OTPResendRequestFromJson(Map<String, dynamic> json) =>
    OTPResendRequest(
      loginTypeID: (json['loginTypeID'] as num?)?.toInt(),
      oTPSession: json['oTPSession'] as String?,
      domain: json['domain'] as String?,
      appid: json['appid'] as String?,
      imei: json['imei'] as String?,
      regKey: json['regKey'] as String?,
      version: json['version'] as String?,
      serialNo: json['serialNo'] as String?,
      isSeller: json['isSeller'] as bool? ?? true,
    );

Map<String, dynamic> _$OTPResendRequestToJson(OTPResendRequest instance) =>
    <String, dynamic>{
      'loginTypeID': instance.loginTypeID,
      'oTPSession': instance.oTPSession,
      'domain': instance.domain,
      'appid': instance.appid,
      'imei': instance.imei,
      'regKey': instance.regKey,
      'version': instance.version,
      'serialNo': instance.serialNo,
      'isSeller': instance.isSeller,
    };
