// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CryptoTransferRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoTransferRequest _$CryptoTransferRequestFromJson(
        Map<String, dynamic> json) =>
    CryptoTransferRequest(
      OTP: json['OTP'] as String?,
      ReferenceId: (json['ReferenceId'] as num?)?.toInt(),
      Amount: json['Amount'] as String?,
      FromCurrId: (json['FromCurrId'] as num?)?.toInt(),
      OTPType: (json['OTPType'] as num?)?.toInt(),
      ToWalletId: (json['ToWalletId'] as num?)?.toInt(),
      TransferType: (json['TransferType'] as num?)?.toInt(),
      FromUserId: (json['FromUserId'] as num?)?.toInt(),
      ToAddress: json['ToAddress'] as String?,
    );

Map<String, dynamic> _$CryptoTransferRequestToJson(
        CryptoTransferRequest instance) =>
    <String, dynamic>{
      'OTP': instance.OTP,
      'ReferenceId': instance.ReferenceId,
      'Amount': instance.Amount,
      'FromCurrId': instance.FromCurrId,
      'OTPType': instance.OTPType,
      'ToWalletId': instance.ToWalletId,
      'TransferType': instance.TransferType,
      'FromUserId': instance.FromUserId,
      'ToAddress': instance.ToAddress,
    };
