// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validateAddress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateAddressApiStruct _$ValidateAddressApiStructFromJson(
        Map<String, dynamic> json) =>
    ValidateAddressApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$ValidateAddressApiStructToJson(
        ValidateAddressApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };
