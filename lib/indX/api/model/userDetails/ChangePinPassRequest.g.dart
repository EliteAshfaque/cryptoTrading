// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChangePinPassRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePinPassRequest _$ChangePinPassRequestFromJson(
        Map<String, dynamic> json) =>
    ChangePinPassRequest(
      json['isPin'] as bool?,
      json['oldP'] as String?,
      json['NewP'] as String?,
      json['ConfirmP'] as String?,
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

Map<String, dynamic> _$ChangePinPassRequestToJson(
        ChangePinPassRequest instance) =>
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
      'isPin': instance.isPin,
      'oldP': instance.oldP,
      'NewP': instance.NewP,
      'ConfirmP': instance.ConfirmP,
    };
