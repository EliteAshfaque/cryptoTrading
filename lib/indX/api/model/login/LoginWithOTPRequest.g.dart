// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginWithOTPRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginWithOTPRequest _$LoginWithOTPRequestFromJson(Map<String, dynamic> json) =>
    LoginWithOTPRequest(
      loginTypeID: (json['loginTypeID'] as num?)?.toInt(),
      MobileNo: json['MobileNo'] as String?,
      Otp: json['Otp'] as String?,
      domain: json['domain'] as String?,
      appid: json['appid'] as String?,
      imei: json['imei'] as String?,
      regKey: json['regKey'] as String?,
      version: json['version'] as String?,
      serialNo: json['serialNo'] as String?,
      isSeller: json['isSeller'] as bool? ?? true,
    );

Map<String, dynamic> _$LoginWithOTPRequestToJson(
        LoginWithOTPRequest instance) =>
    <String, dynamic>{
      'loginTypeID': instance.loginTypeID,
      'MobileNo': instance.MobileNo,
      'Otp': instance.Otp,
      'domain': instance.domain,
      'appid': instance.appid,
      'imei': instance.imei,
      'regKey': instance.regKey,
      'version': instance.version,
      'serialNo': instance.serialNo,
      'isSeller': instance.isSeller,
    };
