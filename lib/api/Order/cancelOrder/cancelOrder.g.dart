// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancelOrder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelOrderApiStruct _$CancelOrderApiStructFromJson(
        Map<String, dynamic> json) =>
    CancelOrderApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$CancelOrderApiStructToJson(
        CancelOrderApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };
