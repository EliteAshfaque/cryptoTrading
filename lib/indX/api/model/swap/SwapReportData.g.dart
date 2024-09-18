// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SwapReportData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SwapReportData _$SwapReportDataFromJson(Map<String, dynamic> json) =>
    SwapReportData(
      swappingId: (json['swappingId'] as num?)?.toInt(),
      swappingWalletId: (json['swappingWalletId'] as num?)?.toInt(),
      tid: (json['tid'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      struserId: json['struserId'] as String?,
      userName: json['userName'] as String?,
      fromCurrency: json['fromCurrency'] as String?,
      toCurrency: json['toCurrency'] as String?,
      transAmount: (json['transAmount'] as num?)?.toDouble(),
      convRate: (json['convRate'] as num?)?.toDouble(),
      convertAmount: (json['convertAmount'] as num?)?.toDouble(),
      status: (json['status'] as num?)?.toInt(),
      status2: (json['status2'] as num?)?.toInt(),
      statusType: json['statusType'] as String?,
      statusType2: json['statusType2'] as String?,
      hashValue: json['hashValue'] as String?,
      hashValue2: json['hashValue2'] as String?,
      requestTime: json['requestTime'] as String?,
      isAdminApproval: json['isAdminApproval'] as bool?,
    );

Map<String, dynamic> _$SwapReportDataToJson(SwapReportData instance) =>
    <String, dynamic>{
      'swappingId': instance.swappingId,
      'swappingWalletId': instance.swappingWalletId,
      'tid': instance.tid,
      'userId': instance.userId,
      'struserId': instance.struserId,
      'userName': instance.userName,
      'fromCurrency': instance.fromCurrency,
      'toCurrency': instance.toCurrency,
      'transAmount': instance.transAmount,
      'convRate': instance.convRate,
      'convertAmount': instance.convertAmount,
      'status': instance.status,
      'status2': instance.status2,
      'statusType': instance.statusType,
      'statusType2': instance.statusType2,
      'hashValue': instance.hashValue,
      'hashValue2': instance.hashValue2,
      'requestTime': instance.requestTime,
      'isAdminApproval': instance.isAdminApproval,
    };
