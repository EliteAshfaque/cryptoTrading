// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ReportRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportRequest _$ReportRequestFromJson(Map<String, dynamic> json) =>
    ReportRequest(
      (json['WalletTypeID'] as num?)?.toInt(),
      json['isExport'] as bool?,
      json['isSelf'] as bool?,
      json['topRows'] as String?,
      (json['status'] as num?)?.toInt(),
      (json['oid'] as num?)?.toInt(),
      json['fromDate'] as String?,
      json['toDate'] as String?,
      json['transactionID'] as String?,
      json['accountNo'] as String?,
      (json['tMode'] as num?)?.toInt(),
      json['uMobile'] as String?,
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

Map<String, dynamic> _$ReportRequestToJson(ReportRequest instance) =>
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
      'WalletTypeID': instance.WalletTypeID,
      'isExport': instance.isExport,
      'isSelf': instance.isSelf,
      'topRows': instance.topRows,
      'status': instance.status,
      'oid': instance.oid,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'transactionID': instance.transactionID,
      'accountNo': instance.accountNo,
      'tMode': instance.tMode,
      'uMobile': instance.uMobile,
    };
