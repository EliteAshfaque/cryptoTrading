// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completedOrderEntries.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletedOrderEntriesApiStruct _$CompletedOrderEntriesApiStructFromJson(
        Map<String, dynamic> json) =>
    CompletedOrderEntriesApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$CompletedOrderEntriesApiStructToJson(
        CompletedOrderEntriesApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

CompletedOrderApiResp _$CompletedOrderApiRespFromJson(
        Map<String, dynamic> json) =>
    CompletedOrderApiResp(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => OrderFillsStruct.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CompletedOrderApiRespToJson(
        CompletedOrderApiResp instance) =>
    <String, dynamic>{
      'data': instance.data,
      'totalCount': instance.totalCount,
    };

OrderFillsStruct _$OrderFillsStructFromJson(Map<String, dynamic> json) =>
    OrderFillsStruct(
      txId: json['txId'] as String?,
      orderPrice: json['orderPrice'] as String?,
      price: json['price'] as String?,
      qty: json['qty'] as String?,
      uniqueId: json['uniqueId'] as String?,
      email: json['email'] as String?,
      symbol: json['symbol'] as String?,
      type: json['type'] as String?,
      createdAt: json['createdAt'] as String?,
      name: json['name'] as String?,
      updatedAt: json['updatedAt'] as String?,
      coinOrderId: json['coinOrderId'] as String?,
      matchId: json['matchId'] as String?,
      matchLedgerId: json['matchLedgerId'] as String?,
      originalOrderQty: json['originalOrderQty'] as String?,
    );

Map<String, dynamic> _$OrderFillsStructToJson(OrderFillsStruct instance) =>
    <String, dynamic>{
      'txId': instance.txId,
      'coinOrderId': instance.coinOrderId,
      'price': instance.price,
      'qty': instance.qty,
      'uniqueId': instance.uniqueId,
      'email': instance.email,
      'type': instance.type,
      'matchId': instance.matchId,
      'matchLedgerId': instance.matchLedgerId,
      'symbol': instance.symbol,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
      'name': instance.name,
      'originalOrderQty': instance.originalOrderQty,
      'orderPrice': instance.orderPrice,
    };
