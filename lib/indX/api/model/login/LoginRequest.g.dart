// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      loginTypeID: (json['loginTypeID'] as num?)?.toInt(),
      userID: json['userID'] as String?,
      password: json['password'] as String?,
      domain: json['domain'] as String?,
      appid: json['appid'] as String?,
      imei: json['imei'] as String?,
      regKey: json['regKey'] as String?,
      version: json['version'] as String?,
      serialNo: json['serialNo'] as String?,
      isSeller: json['isSeller'] as bool? ?? true,
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'loginTypeID': instance.loginTypeID,
      'userID': instance.userID,
      'password': instance.password,
      'domain': instance.domain,
      'appid': instance.appid,
      'imei': instance.imei,
      'regKey': instance.regKey,
      'version': instance.version,
      'serialNo': instance.serialNo,
      'isSeller': instance.isSeller,
    };
