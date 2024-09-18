// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LedgerReport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LedgerReport _$LedgerReportFromJson(Map<String, dynamic> json) => LedgerReport(
      tid: json['tid'] as String?,
      remark: json['remark'] as String?,
      description: json['description'] as String?,
      mobileNo: json['mobileNo'] as String?,
      id: (json['id'] as num?)?.toInt(),
      serviceID: (json['serviceID'] as num?)?.toInt(),
      lastAmount: (json['lastAmount'] as num?)?.toDouble(),
      curentBalance: (json['curentBalance'] as num?)?.toDouble(),
      credit: (json['credit'] as num?)?.toDouble(),
      debit: (json['debit'] as num?)?.toDouble(),
      topRows: (json['topRows'] as num?)?.toInt(),
      lType: json['lType'] as bool?,
      user: json['user'] as String?,
      userID: json['userID'] as String?,
      entryDate: json['entryDate'] as String?,
    );

Map<String, dynamic> _$LedgerReportToJson(LedgerReport instance) =>
    <String, dynamic>{
      'tid': instance.tid,
      'remark': instance.remark,
      'description': instance.description,
      'mobileNo': instance.mobileNo,
      'id': instance.id,
      'serviceID': instance.serviceID,
      'lastAmount': instance.lastAmount,
      'curentBalance': instance.curentBalance,
      'credit': instance.credit,
      'debit': instance.debit,
      'topRows': instance.topRows,
      'lType': instance.lType,
      'user': instance.user,
      'userID': instance.userID,
      'entryDate': instance.entryDate,
    };
