// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CurrencyToWalletTransferMapping.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyToWalletTransferMapping _$CurrencyToWalletTransferMappingFromJson(
        Map<String, dynamic> json) =>
    CurrencyToWalletTransferMapping(
      fromCurrId: (json['fromCurrId'] as num?)?.toInt(),
      toWalletId: (json['toWalletId'] as num?)?.toInt(),
      walletCurrencyId: (json['walletCurrencyId'] as num?)?.toInt(),
      fromCurrName: json['fromCurrName'] as String?,
      walletCurrencySymbol: json['walletCurrencySymbol'] as String?,
      walletCurrencyName: json['walletCurrencyName'] as String?,
      toWalletName: json['toWalletName'] as String?,
      withdrawlCharges: (json['withdrawlCharges'] as num?)?.toDouble(),
      transferCharges: (json['transferCharges'] as num?)?.toDouble(),
      fromCurrSymbol: json['fromCurrSymbol'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$CurrencyToWalletTransferMappingToJson(
        CurrencyToWalletTransferMapping instance) =>
    <String, dynamic>{
      'fromCurrId': instance.fromCurrId,
      'toWalletId': instance.toWalletId,
      'walletCurrencyId': instance.walletCurrencyId,
      'fromCurrName': instance.fromCurrName,
      'walletCurrencySymbol': instance.walletCurrencySymbol,
      'walletCurrencyName': instance.walletCurrencyName,
      'toWalletName': instance.toWalletName,
      'withdrawlCharges': instance.withdrawlCharges,
      'transferCharges': instance.transferCharges,
      'fromCurrSymbol': instance.fromCurrSymbol,
      'imageUrl': instance.imageUrl,
    };
