// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IncomeWiseReportRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncomeWiseReportRequest _$IncomeWiseReportRequestFromJson(
        Map<String, dynamic> json) =>
    IncomeWiseReportRequest(
      (json['incomeCategoryID'] as num?)?.toInt(),
      (json['OPID'] as num?)?.toInt(),
      json['FromDate'] as String?,
      json['ToDate'] as String?,
      json['LevelNo'] as String?,
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

Map<String, dynamic> _$IncomeWiseReportRequestToJson(
        IncomeWiseReportRequest instance) =>
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
      'incomeCategoryID': instance.incomeCategoryID,
      'OPID': instance.OPID,
      'FromDate': instance.FromDate,
      'ToDate': instance.ToDate,
      'LevelNo': instance.LevelNo,
    };
