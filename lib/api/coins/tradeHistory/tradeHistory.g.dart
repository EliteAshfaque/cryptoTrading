// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tradeHistory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TradeHistoryApiStruct _$TradeHistoryApiStructFromJson(
        Map<String, dynamic> json) =>
    TradeHistoryApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$TradeHistoryApiStructToJson(
        TradeHistoryApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

TradeHistoryStruct _$TradeHistoryStructFromJson(Map<String, dynamic> json) =>
    TradeHistoryStruct(
      price: json['price'] as String?,
      symbol: json['symbol'] as String?,
      colorBool: json['colorBool'] as bool?,
      createdAt: json['createdAt'] as String?,
      isDisplay: json['isDisplay'] as bool?,
      qty: json['qty'] as String?,
    );

Map<String, dynamic> _$TradeHistoryStructToJson(TradeHistoryStruct instance) =>
    <String, dynamic>{
      'price': instance.price,
      'qty': instance.qty,
      'symbol': instance.symbol,
      'colorBool': instance.colorBool,
      'isDisplay': instance.isDisplay,
      'createdAt': instance.createdAt,
    };
