// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StakingDetailData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StakingDetailData _$StakingDetailDataFromJson(Map<String, dynamic> json) =>
    StakingDetailData(
      planName: json['planName'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      purchaseDate: json['purchaseDate'] as String?,
      withdrawalDate: json['withdrawalDate'] as String?,
      lastwithdrwalDate: json['lastwithdrwalDate'] as String?,
    );

Map<String, dynamic> _$StakingDetailDataToJson(StakingDetailData instance) =>
    <String, dynamic>{
      'planName': instance.planName,
      'amount': instance.amount,
      'purchaseDate': instance.purchaseDate,
      'withdrawalDate': instance.withdrawalDate,
      'lastwithdrwalDate': instance.lastwithdrwalDate,
    };
