// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BalanceData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceData _$BalanceDataFromJson(Map<String, dynamic> json) => BalanceData(
      walletCurrencyID: (json['walletCurrencyID'] as num?)?.toInt(),
      walletCurrencyName: json['walletCurrencyName'] as String?,
      walletCurrencySymbol: json['walletCurrencySymbol'] as String?,
      id: (json['id'] as num?)?.toInt(),
      walletType: json['walletType'] as String?,
      inFundProcess: json['inFundProcess'] as bool?,
      preferredForShoping: (json['preferredForShoping'] as num?)?.toInt(),
      deductionPercent: (json['deductionPercent'] as num?)?.toDouble(),
      isPackageDedectionForRetailor:
          json['isPackageDedectionForRetailor'] as bool?,
      minTransferAmount: (json['minTransferAmount'] as num?)?.toDouble(),
      maxTransferAmount: (json['maxTransferAmount'] as num?)?.toDouble(),
      maxTransaferCount: (json['maxTransaferCount'] as num?)?.toDouble(),
      minWithdrawalAmount: (json['minWithdrawalAmount'] as num?)?.toDouble(),
      maxWithdrawalAmount: (json['maxWithdrawalAmount'] as num?)?.toDouble(),
      maxWithdrawalCount: (json['maxWithdrawalCount'] as num?)?.toDouble(),
      walletTransferType: (json['walletTransferType'] as num?)?.toInt(),
      withdrawalType: (json['withdrawalType'] as num?)?.toInt(),
      isWithdrawal: json['isWithdrawal'] as bool?,
      balance: (json['balance'] as num?)?.toDouble(),
      capping: (json['capping'] as num?)?.toDouble(),
      allowedWallet: (json['allowedWallet'] as List<dynamic>?)
          ?.map((e) => AllowedWallet.fromJson(e as Map<String, dynamic>))
          .toList(),
      allowedWithdrawalType: (json['allowedWithdrawalType'] as List<dynamic>?)
          ?.map(
              (e) => AllowedWithdrawalType.fromJson(e as Map<String, dynamic>))
          .toList(),
      allowedWalletToCripto: (json['allowedWalletToCripto'] as List<dynamic>?)
          ?.map(
              (e) => AllowedWalletToCrypto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BalanceDataToJson(BalanceData instance) =>
    <String, dynamic>{
      'walletCurrencyID': instance.walletCurrencyID,
      'walletCurrencyName': instance.walletCurrencyName,
      'walletCurrencySymbol': instance.walletCurrencySymbol,
      'id': instance.id,
      'walletType': instance.walletType,
      'inFundProcess': instance.inFundProcess,
      'preferredForShoping': instance.preferredForShoping,
      'deductionPercent': instance.deductionPercent,
      'isPackageDedectionForRetailor': instance.isPackageDedectionForRetailor,
      'minTransferAmount': instance.minTransferAmount,
      'maxTransferAmount': instance.maxTransferAmount,
      'maxTransaferCount': instance.maxTransaferCount,
      'minWithdrawalAmount': instance.minWithdrawalAmount,
      'maxWithdrawalAmount': instance.maxWithdrawalAmount,
      'maxWithdrawalCount': instance.maxWithdrawalCount,
      'walletTransferType': instance.walletTransferType,
      'withdrawalType': instance.withdrawalType,
      'isWithdrawal': instance.isWithdrawal,
      'balance': instance.balance,
      'capping': instance.capping,
      'allowedWallet': instance.allowedWallet,
      'allowedWithdrawalType': instance.allowedWithdrawalType,
      'allowedWalletToCripto': instance.allowedWalletToCripto,
    };
