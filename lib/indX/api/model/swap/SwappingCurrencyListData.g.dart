// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SwappingCurrencyListData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SwappingCurrencyListData _$SwappingCurrencyListDataFromJson(
        Map<String, dynamic> json) =>
    SwappingCurrencyListData(
      fromTechnologyId: (json['fromTechnologyId'] as num?)?.toInt(),
      fromCurrId: (json['fromCurrId'] as num?)?.toInt(),
      symbol: json['symbol'] as String?,
      name: json['name'] as String?,
      fromImageUrl: json['fromImageUrl'] as String?,
      toCurrency: (json['toCurrency'] as List<dynamic>?)
          ?.map((e) =>
              SwappingCurrencyListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      toTechnologyId: (json['toTechnologyId'] as num?)?.toInt(),
      toCurrId: (json['toCurrId'] as num?)?.toInt(),
      toImageUrl: json['toImageUrl'] as String?,
      rate: (json['rate'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SwappingCurrencyListDataToJson(
        SwappingCurrencyListData instance) =>
    <String, dynamic>{
      'fromTechnologyId': instance.fromTechnologyId,
      'fromCurrId': instance.fromCurrId,
      'symbol': instance.symbol,
      'name': instance.name,
      'fromImageUrl': instance.fromImageUrl,
      'toCurrency': instance.toCurrency,
      'toTechnologyId': instance.toTechnologyId,
      'toCurrId': instance.toCurrId,
      'toImageUrl': instance.toImageUrl,
      'rate': instance.rate,
    };
