// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WalletTypeList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletTypeList _$WalletTypeListFromJson(Map<String, dynamic> json) =>
    WalletTypeList(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      currencyID: (json['currencyID'] as num?)?.toInt(),
      currencyName: json['currencyName'] as String?,
      symbol: json['symbol'] as String?,
      imageUrl: json['imageUrl'] as String?,
      displayConversionCurrId:
          (json['displayConversionCurrId'] as num?)?.toInt(),
      displayConversionCurrSymbol:
          json['displayConversionCurrSymbol'] as String?,
      displayConversionCurrImage: json['displayConversionCurrImage'] as String?,
      userBalance: (json['userBalance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WalletTypeListToJson(WalletTypeList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'currencyID': instance.currencyID,
      'currencyName': instance.currencyName,
      'symbol': instance.symbol,
      'imageUrl': instance.imageUrl,
      'displayConversionCurrId': instance.displayConversionCurrId,
      'displayConversionCurrSymbol': instance.displayConversionCurrSymbol,
      'displayConversionCurrImage': instance.displayConversionCurrImage,
      'userBalance': instance.userBalance,
    };
