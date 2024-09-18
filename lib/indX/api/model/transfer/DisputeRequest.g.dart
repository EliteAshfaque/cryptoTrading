// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DisputeRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DisputeRequest _$DisputeRequestFromJson(Map<String, dynamic> json) =>
    DisputeRequest(
      (json['tid'] as num?)?.toInt(),
      json['transactionID'] as String?,
      json['isResend'] as bool?,
      json['otp'] as String?,
      json['refID'] as String?,
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

Map<String, dynamic> _$DisputeRequestToJson(DisputeRequest instance) =>
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
      'tid': instance.tid,
      'transactionID': instance.transactionID,
      'isResend': instance.isResend,
      'otp': instance.otp,
      'refID': instance.refID,
    };
