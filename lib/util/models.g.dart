// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderPlacingModel _$OrderPlacingModelFromJson(Map<String, dynamic> json) =>
    OrderPlacingModel(
      price: json['price'] as String,
      qty: json['qty'] as String,
    );

Map<String, dynamic> _$OrderPlacingModelToJson(OrderPlacingModel instance) =>
    <String, dynamic>{
      'price': instance.price,
      'qty': instance.qty,
    };
