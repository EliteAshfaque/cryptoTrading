// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WithdrawalWalletReport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawalWalletReport _$WithdrawalWalletReportFromJson(
        Map<String, dynamic> json) =>
    WithdrawalWalletReport(
      tid: (json['tid'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      userName: json['userName'] as String?,
      requestedAmount: (json['requestedAmount'] as num?)?.toDouble(),
      fromCurrencyName: json['fromCurrencyName'] as String?,
      toCurrencyName: json['toCurrencyName'] as String?,
      toWallet: json['toWallet'] as String?,
      convsertionRate: (json['convsertionRate'] as num?)?.toDouble(),
      liveRate: (json['liveRate'] as num?)?.toDouble(),
      transferAmount: (json['transferAmount'] as num?)?.toDouble(),
      liveId: json['liveId'] as String?,
      entryDate: json['entryDate'] as String?,
      toAddress: json['toAddress'] as String?,
    );

Map<String, dynamic> _$WithdrawalWalletReportToJson(
        WithdrawalWalletReport instance) =>
    <String, dynamic>{
      'tid': instance.tid,
      'userId': instance.userId,
      'status': instance.status,
      'userName': instance.userName,
      'requestedAmount': instance.requestedAmount,
      'fromCurrencyName': instance.fromCurrencyName,
      'toCurrencyName': instance.toCurrencyName,
      'toWallet': instance.toWallet,
      'convsertionRate': instance.convsertionRate,
      'liveRate': instance.liveRate,
      'transferAmount': instance.transferAmount,
      'liveId': instance.liveId,
      'entryDate': instance.entryDate,
      'toAddress': instance.toAddress,
    };
