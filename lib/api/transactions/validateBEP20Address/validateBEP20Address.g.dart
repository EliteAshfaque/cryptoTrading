// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validateBEP20Address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidateBEP20AddressApiStruct _$ValidateBEP20AddressApiStructFromJson(
        Map<String, dynamic> json) =>
    ValidateBEP20AddressApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$ValidateBEP20AddressApiStructToJson(
        ValidateBEP20AddressApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };
