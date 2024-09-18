// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WalletTransferRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletTransferRequest _$WalletTransferRequestFromJson(
        Map<String, dynamic> json) =>
    WalletTransferRequest(
      ExternalAddress: json['ExternalAddress'] as String?,
      OTP: json['OTP'] as String?,
      OTPRefId: (json['OTPRefId'] as num?)?.toInt(),
      OTPType: (json['OTPType'] as num?)?.toInt(),
      ToUserId: (json['ToUserId'] as num?)?.toInt(),
      Amount: json['Amount'] as String?,
      ToWithdrwalType: (json['ToWithdrwalType'] as num?)?.toInt(),
      ToWalletId: (json['ToWalletId'] as num?)?.toInt(),
      FromWalletId: (json['FromWalletId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WalletTransferRequestToJson(
        WalletTransferRequest instance) =>
    <String, dynamic>{
      'ExternalAddress': instance.ExternalAddress,
      'OTP': instance.OTP,
      'OTPRefId': instance.OTPRefId,
      'OTPType': instance.OTPType,
      'ToUserId': instance.ToUserId,
      'Amount': instance.Amount,
      'ToWithdrwalType': instance.ToWithdrwalType,
      'ToWalletId': instance.ToWalletId,
      'FromWalletId': instance.FromWalletId,
    };
