// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ActivateUserRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivateUserRequest _$ActivateUserRequestFromJson(Map<String, dynamic> json) =>
    ActivateUserRequest(
      (json['WalletId'] as num?)?.toInt(),
      json['TopupUserId'] as String?,
      (json['PackageID'] as num?)?.toInt(),
      (json['BusinessType'] as num?)?.toInt(),
      json['EPin'] as String?,
      json['PackageAmount'] as String?,
      (json['FromCurrencyId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ActivateUserRequestToJson(
        ActivateUserRequest instance) =>
    <String, dynamic>{
      'WalletId': instance.WalletId,
      'TopupUserId': instance.TopupUserId,
      'PackageID': instance.PackageID,
      'BusinessType': instance.BusinessType,
      'EPin': instance.EPin,
      'PackageAmount': instance.PackageAmount,
      'FromCurrencyId': instance.FromCurrencyId,
    };
