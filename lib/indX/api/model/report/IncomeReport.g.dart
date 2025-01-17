// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IncomeReport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncomeReport _$IncomeReportFromJson(Map<String, dynamic> json) => IncomeReport(
      resultCode: (json['resultCode'] as num?)?.toInt(),
      msg: json['msg'] as String?,
      tid: (json['tid'] as num?)?.toInt(),
      name: json['name'] as String?,
      totalCreditedAmount: (json['totalCreditedAmount'] as num?)?.toDouble(),
      binaryIncome: (json['binaryIncome'] as num?)?.toDouble(),
      lapsIncome: json['lapsIncome'] as String?,
      payoutDate: json['payoutDate'] as String?,
      creditedAmount: (json['creditedAmount'] as num?)?.toDouble(),
      adminCharge: json['adminCharge'] as String?,
      incomeOPID: json['incomeOPID'] as String?,
      fromName: json['fromName'] as String?,
      fromUserId: json['fromUserId'] as String?,
      toName: json['toName'] as String?,
      toUserId: json['toUserId'] as String?,
      entryDate: json['entryDate'] as String?,
      incomeName: json['incomeName'] as String?,
      fromTeamOf: json['fromTeamOf'] as String?,
      todayMatchBusiness: json['todayMatchBusiness'] as String?,
      totalRightBusiness: json['totalRightBusiness'] as String?,
      totalLeftBusiness: json['totalLeftBusiness'] as String?,
      levelNo: json['levelNo'] as String?,
    );

Map<String, dynamic> _$IncomeReportToJson(IncomeReport instance) =>
    <String, dynamic>{
      'resultCode': instance.resultCode,
      'msg': instance.msg,
      'tid': instance.tid,
      'name': instance.name,
      'totalCreditedAmount': instance.totalCreditedAmount,
      'binaryIncome': instance.binaryIncome,
      'lapsIncome': instance.lapsIncome,
      'payoutDate': instance.payoutDate,
      'creditedAmount': instance.creditedAmount,
      'adminCharge': instance.adminCharge,
      'incomeOPID': instance.incomeOPID,
      'fromName': instance.fromName,
      'fromUserId': instance.fromUserId,
      'toName': instance.toName,
      'toUserId': instance.toUserId,
      'entryDate': instance.entryDate,
      'incomeName': instance.incomeName,
      'fromTeamOf': instance.fromTeamOf,
      'todayMatchBusiness': instance.todayMatchBusiness,
      'totalRightBusiness': instance.totalRightBusiness,
      'totalLeftBusiness': instance.totalLeftBusiness,
      'levelNo': instance.levelNo,
    };
