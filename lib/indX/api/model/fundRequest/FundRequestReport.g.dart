// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FundRequestReport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FundRequestReport _$FundRequestReportFromJson(Map<String, dynamic> json) =>
    FundRequestReport(
      status: json['status'] as String?,
      bank: json['bank'] as String?,
      accountNo: json['accountNo'] as String?,
      transactionId: json['transactionId'] as String?,
      accountHolder: json['accountHolder'] as String?,
      entryDate: json['entryDate'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      approveDate: json['approveDate'] as String?,
    );

Map<String, dynamic> _$FundRequestReportToJson(FundRequestReport instance) =>
    <String, dynamic>{
      'status': instance.status,
      'bank': instance.bank,
      'accountNo': instance.accountNo,
      'transactionId': instance.transactionId,
      'accountHolder': instance.accountHolder,
      'entryDate': instance.entryDate,
      'amount': instance.amount,
      'approveDate': instance.approveDate,
    };
