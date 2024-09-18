// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_unique_code_struct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerateUnique _$GenerateUniqueFromJson(Map<String, dynamic> json) =>
    GenerateUnique(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$GenerateUniqueToJson(GenerateUnique instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

GenerateUniqueCodeStruct _$GenerateUniqueCodeStructFromJson(
        Map<String, dynamic> json) =>
    GenerateUniqueCodeStruct(
      message: json['message'] as String,
    );

Map<String, dynamic> _$GenerateUniqueCodeStructToJson(
        GenerateUniqueCodeStruct instance) =>
    <String, dynamic>{
      'message': instance.message,
    };
