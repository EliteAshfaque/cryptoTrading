// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SendMoneyBankReportRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendMoneyBankReportRequest _$SendMoneyBankReportRequestFromJson(
        Map<String, dynamic> json) =>
    SendMoneyBankReportRequest(
      json['topRows'] as String?,
      (json['status'] as num?)?.toInt(),
      json['apiid'] as String?,
      json['fromDate'] as String?,
      json['toDate'] as String?,
      json['childMobile'] as String?,
      json['transactionID'] as String?,
      json['accountNo'] as String?,
      json['isExport'] as bool,
      json['IsRecent'] as bool,
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

Map<String, dynamic> _$SendMoneyBankReportRequestToJson(
        SendMoneyBankReportRequest instance) =>
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
      'topRows': instance.topRows,
      'status': instance.status,
      'apiid': instance.apiid,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'childMobile': instance.childMobile,
      'transactionID': instance.transactionID,
      'accountNo': instance.accountNo,
      'isExport': instance.isExport,
      'IsRecent': instance.IsRecent,
    };
