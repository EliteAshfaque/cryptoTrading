// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SignupRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupRequest _$SignupRequestFromJson(Map<String, dynamic> json) =>
    SignupRequest(
      referalID: json['referalID'] as String?,
      referalIDstr: json['referalIDstr'] as String?,
      legs: json['legs'] as String?,
      domain: json['domain'] as String?,
      appid: json['appid'] as String?,
      imei: json['imei'] as String?,
      regKey: json['regKey'] as String?,
      version: json['version'] as String?,
      serialNo: json['serialNo'] as String?,
      isSeller: json['isSeller'] as bool? ?? true,
      userCreate: json['userCreate'] == null
          ? null
          : UserCreateSignup.fromJson(
              json['userCreate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignupRequestToJson(SignupRequest instance) =>
    <String, dynamic>{
      'referalID': instance.referalID,
      'referalIDstr': instance.referalIDstr,
      'legs': instance.legs,
      'domain': instance.domain,
      'appid': instance.appid,
      'imei': instance.imei,
      'regKey': instance.regKey,
      'version': instance.version,
      'serialNo': instance.serialNo,
      'isSeller': instance.isSeller,
      'userCreate': instance.userCreate,
    };
