// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OTPRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTPRequest _$OTPRequestFromJson(Map<String, dynamic> json) => OTPRequest(
      loginTypeID: (json['loginTypeID'] as num?)?.toInt(),
      otp: json['otp'] as String?,
      oTPSession: json['oTPSession'] as String?,
      oTPType: (json['oTPType'] as num?)?.toInt(),
      domain: json['domain'] as String?,
      appid: json['appid'] as String?,
      imei: json['imei'] as String?,
      regKey: json['regKey'] as String?,
      version: json['version'] as String?,
      serialNo: json['serialNo'] as String?,
      isSeller: json['isSeller'] as bool? ?? true,
    );

Map<String, dynamic> _$OTPRequestToJson(OTPRequest instance) =>
    <String, dynamic>{
      'loginTypeID': instance.loginTypeID,
      'otp': instance.otp,
      'oTPSession': instance.oTPSession,
      'oTPType': instance.oTPType,
      'domain': instance.domain,
      'appid': instance.appid,
      'imei': instance.imei,
      'regKey': instance.regKey,
      'version': instance.version,
      'serialNo': instance.serialNo,
      'isSeller': instance.isSeller,
    };
