// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RoleRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoleRequest _$RoleRequestFromJson(Map<String, dynamic> json) => RoleRequest(
      referralID: json['referralID'] as String?,
      domain: json['domain'] as String?,
      appid: json['appid'] as String?,
      imei: json['imei'] as String?,
      regKey: json['regKey'] as String?,
      version: json['version'] as String?,
      serialNo: json['serialNo'] as String?,
      isSeller: json['isSeller'] as bool? ?? true,
    );

Map<String, dynamic> _$RoleRequestToJson(RoleRequest instance) =>
    <String, dynamic>{
      'referralID': instance.referralID,
      'domain': instance.domain,
      'appid': instance.appid,
      'imei': instance.imei,
      'regKey': instance.regKey,
      'version': instance.version,
      'serialNo': instance.serialNo,
      'isSeller': instance.isSeller,
    };
