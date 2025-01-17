// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LiveRateData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveRateData _$LiveRateDataFromJson(Map<String, dynamic> json) => LiveRateData(
      id: (json['id'] as num?)?.toInt(),
      walletId: (json['walletId'] as num?)?.toInt(),
      opid: (json['opid'] as num?)?.toInt(),
      technologyId: (json['technologyId'] as num?)?.toInt(),
      currencyId: (json['currencyId'] as num?)?.toInt(),
      currencyID: (json['currencyID'] as num?)?.toInt(),
      bcmid: (json['bcmid'] as num?)?.toInt(),
      walletName: json['walletName'] as String?,
      businessName: json['businessName'] as String?,
      currencyName: json['currencyName'] as String?,
      isBalanceFromDB: json['isBalanceFromDB'] as bool?,
      balance: (json['balance'] as num?)?.toDouble(),
      currecySymbol: json['currecySymbol'] as String?,
      currencySymbol: json['currencySymbol'] as String?,
      symbol: json['symbol'] as String?,
      displayConversionCurrSymbol:
          json['displayConversionCurrSymbol'] as String?,
      displayConversionCurrImage: json['displayConversionCurrImage'] as String?,
      displayConversionCurrId:
          (json['displayConversionCurrId'] as num?)?.toInt(),
      isActive: json['isActive'] as bool?,
      isCoin: json['isCoin'] as bool?,
      decimalSupport: (json['decimalSupport'] as num?)?.toDouble(),
      isTransferAllowed: json['isTransferAllowed'] as bool?,
      isDepositAllowed: json['isDepositAllowed'] as bool?,
      isDisplayLiveRate: json['isDisplayLiveRate'] as bool?,
      isAutoDeposit: json['isAutoDeposit'] as bool?,
      minTransfer: (json['minTransfer'] as num?)?.toDouble(),
      maxTransfer: (json['maxTransfer'] as num?)?.toDouble(),
      imageUrls: json['imageUrls'] as String?,
      isDisplayBalance: json['isDisplayBalance'] as bool?,
      allowedTransferMappings: (json['allowedTransferMappings']
              as List<dynamic>?)
          ?.map((e) => AllowTransferMapping.fromJson(e as Map<String, dynamic>))
          .toList(),
      currencyToWalletTransferMappings:
          (json['currencyToWalletTransferMappings'] as List<dynamic>?)
              ?.map((e) => CurrencyToWalletTransferMapping.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$LiveRateDataToJson(LiveRateData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'walletId': instance.walletId,
      'opid': instance.opid,
      'technologyId': instance.technologyId,
      'currencyId': instance.currencyId,
      'currencyID': instance.currencyID,
      'bcmid': instance.bcmid,
      'walletName': instance.walletName,
      'businessName': instance.businessName,
      'currencyName': instance.currencyName,
      'isBalanceFromDB': instance.isBalanceFromDB,
      'balance': instance.balance,
      'currecySymbol': instance.currecySymbol,
      'currencySymbol': instance.currencySymbol,
      'symbol': instance.symbol,
      'displayConversionCurrSymbol': instance.displayConversionCurrSymbol,
      'displayConversionCurrImage': instance.displayConversionCurrImage,
      'displayConversionCurrId': instance.displayConversionCurrId,
      'isActive': instance.isActive,
      'isCoin': instance.isCoin,
      'decimalSupport': instance.decimalSupport,
      'isTransferAllowed': instance.isTransferAllowed,
      'isDepositAllowed': instance.isDepositAllowed,
      'isDisplayLiveRate': instance.isDisplayLiveRate,
      'isAutoDeposit': instance.isAutoDeposit,
      'minTransfer': instance.minTransfer,
      'maxTransfer': instance.maxTransfer,
      'imageUrls': instance.imageUrls,
      'isDisplayBalance': instance.isDisplayBalance,
      'allowedTransferMappings': instance.allowedTransferMappings,
      'currencyToWalletTransferMappings':
          instance.currencyToWalletTransferMappings,
    };
