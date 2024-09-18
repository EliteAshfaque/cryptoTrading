// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'placeOrder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceOrderApiStruct _$PlaceOrderApiStructFromJson(Map<String, dynamic> json) =>
    PlaceOrderApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$PlaceOrderApiStructToJson(
        PlaceOrderApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

PlaceOrderStruct _$PlaceOrderStructFromJson(Map<String, dynamic> json) =>
    PlaceOrderStruct(
      type: json['type'] as String?,
      totalQty: json['totalQty'] as String?,
      symbol: json['symbol'] as String?,
      totalPrice: json['totalPrice'] as String?,
    );

Map<String, dynamic> _$PlaceOrderStructToJson(PlaceOrderStruct instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'type': instance.type,
      'totalQty': instance.totalQty,
      'totalPrice': instance.totalPrice,
    };
