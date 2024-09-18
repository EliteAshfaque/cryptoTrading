// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WithdrawalReportRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawalReportRequest _$WithdrawalReportRequestFromJson(
        Map<String, dynamic> json) =>
    WithdrawalReportRequest(
      CurrencyId: (json['CurrencyId'] as num?)?.toInt(),
      FromDate: json['FromDate'] as String?,
      ToDate: json['ToDate'] as String?,
      WalletId: (json['WalletId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WithdrawalReportRequestToJson(
        WithdrawalReportRequest instance) =>
    <String, dynamic>{
      'CurrencyId': instance.CurrencyId,
      'FromDate': instance.FromDate,
      'ToDate': instance.ToDate,
      'WalletId': instance.WalletId,
    };
