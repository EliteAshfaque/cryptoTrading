// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unique_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UniqueCodeStruct _$UniqueCodeStructFromJson(Map<String, dynamic> json) =>
    UniqueCodeStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$UniqueCodeStructToJson(UniqueCodeStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

UniqueCode _$UniqueCodeFromJson(Map<String, dynamic> json) => UniqueCode(
      isExpired: json['isExpired'] as bool?,
      id: json['_id'] as String?,
      paymentMode: json['paymentMode'] as String?,
      uniqueCode: json['uniqueCode'] as String?,
      email: json['email'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: (json['v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UniqueCodeToJson(UniqueCode instance) =>
    <String, dynamic>{
      'isExpired': instance.isExpired,
      '_id': instance.id,
      'paymentMode': instance.paymentMode,
      'uniqueCode': instance.uniqueCode,
      'email': instance.email,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'v': instance.v,
    };
