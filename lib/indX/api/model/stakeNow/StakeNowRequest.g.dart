// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StakeNowRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StakeNowRequest _$StakeNowRequestFromJson(Map<String, dynamic> json) =>
    StakeNowRequest(
      Amount: json['Amount'] as String?,
      stakeCurrID: (json['stakeCurrID'] as num?)?.toInt(),
      TopupUserId: json['TopupUserId'] as String?,
      WalletId: (json['WalletId'] as num?)?.toInt(),
      PackageID: (json['PackageID'] as num?)?.toInt(),
      BusinessType: (json['BusinessType'] as num?)?.toInt(),
      PackageAmount: json['PackageAmount'] as String?,
      FromCurrencyId: (json['FromCurrencyId'] as num?)?.toInt(),
      StakeType: (json['StakeType'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StakeNowRequestToJson(StakeNowRequest instance) =>
    <String, dynamic>{
      'Amount': instance.Amount,
      'stakeCurrID': instance.stakeCurrID,
      'TopupUserId': instance.TopupUserId,
      'WalletId': instance.WalletId,
      'PackageID': instance.PackageID,
      'BusinessType': instance.BusinessType,
      'PackageAmount': instance.PackageAmount,
      'FromCurrencyId': instance.FromCurrencyId,
      'StakeType': instance.StakeType,
    };
