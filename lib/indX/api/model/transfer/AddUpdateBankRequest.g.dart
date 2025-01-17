// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddUpdateBankRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddUpdateBankRequest _$AddUpdateBankRequestFromJson(
        Map<String, dynamic> json) =>
    AddUpdateBankRequest(
      json['AccountOTP'] as String?,
      (json['ReferenceID'] as num?)?.toInt(),
      json['AccountHolder'] as String?,
      json['AccountNumber'] as String?,
      (json['BankID'] as num?)?.toInt(),
      json['BankName'] as String?,
      json['ifsc'] as String?,
      json['UTR'] as String?,
      (json['UpdateID'] as num?)?.toInt(),
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

Map<String, dynamic> _$AddUpdateBankRequestToJson(
        AddUpdateBankRequest instance) =>
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
      'AccountOTP': instance.AccountOTP,
      'ReferenceID': instance.ReferenceID,
      'AccountHolder': instance.AccountHolder,
      'AccountNumber': instance.AccountNumber,
      'BankID': instance.BankID,
      'BankName': instance.BankName,
      'ifsc': instance.ifsc,
      'UTR': instance.UTR,
      'UpdateID': instance.UpdateID,
    };
