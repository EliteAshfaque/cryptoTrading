// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refreshMobileToken.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshMobilTokenApiStruct _$RefreshMobilTokenApiStructFromJson(
        Map<String, dynamic> json) =>
    RefreshMobilTokenApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$RefreshMobilTokenApiStructToJson(
        RefreshMobilTokenApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };
