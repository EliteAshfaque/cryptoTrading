// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderBook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderBookStruct _$OrderBookStructFromJson(Map<String, dynamic> json) =>
    OrderBookStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$OrderBookStructToJson(OrderBookStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

AllOrderResponse _$AllOrderResponseFromJson(Map<String, dynamic> json) =>
    AllOrderResponse(
      buy: (json['buy'] as List<dynamic>?)
          ?.map((e) => OrderResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      sell: (json['sell'] as List<dynamic>?)
          ?.map((e) => OrderResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllOrderResponseToJson(AllOrderResponse instance) =>
    <String, dynamic>{
      'buy': instance.buy,
      'sell': instance.sell,
    };

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) =>
    OrderResponse(
      price: json['price'],
      totalQty: (json['totalQty'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      'price': instance.price,
      'totalQty': instance.totalQty,
    };
