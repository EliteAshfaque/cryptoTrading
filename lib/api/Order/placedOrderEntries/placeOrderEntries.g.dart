// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'placeOrderEntries.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceOrderEntriesApiStruct _$PlaceOrderEntriesApiStructFromJson(
        Map<String, dynamic> json) =>
    PlaceOrderEntriesApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$PlaceOrderEntriesApiStructToJson(
        PlaceOrderEntriesApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

PlacedAndCancelledApiResp _$PlacedAndCancelledApiRespFromJson(
        Map<String, dynamic> json) =>
    PlacedAndCancelledApiResp(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => OrderSchedulerStruct.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PlacedAndCancelledApiRespToJson(
        PlacedAndCancelledApiResp instance) =>
    <String, dynamic>{
      'data': instance.data,
      'totalCount': instance.totalCount,
    };

OrderSchedulerStruct _$OrderSchedulerStructFromJson(
        Map<String, dynamic> json) =>
    OrderSchedulerStruct(
      name: json['name'] as String?,
      createdAt: json['createdAt'] as String?,
      status: json['status'] as String?,
      type: json['type'] as String?,
      symbol: json['symbol'] as String?,
      email: json['email'] as String?,
      uniqueId: json['uniqueId'] as String?,
      totalQty: json['totalQty'] as String?,
      coin: json['coin'] as String?,
      qty: json['qty'] as String?,
      price: json['price'] as String?,
      orderOriginalQty: json['orderOriginalQty'] as String?,
      orderPrice: json['orderPrice'] as String?,
      txId: json['txId'] as String?,
    );

Map<String, dynamic> _$OrderSchedulerStructToJson(
        OrderSchedulerStruct instance) =>
    <String, dynamic>{
      'status': instance.status,
      'coin': instance.coin,
      'email': instance.email,
      'price': instance.price,
      'qty': instance.qty,
      'symbol': instance.symbol,
      'type': instance.type,
      'uniqueId': instance.uniqueId,
      'totalQty': instance.totalQty,
      'txId': instance.txId,
      'orderOriginalQty': instance.orderOriginalQty,
      'orderPrice': instance.orderPrice,
      'createdAt': instance.createdAt,
      'name': instance.name,
    };
