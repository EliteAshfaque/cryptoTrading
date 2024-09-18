// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'createUserBank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserBankApiStruct _$CreateUserBankApiStructFromJson(
        Map<String, dynamic> json) =>
    CreateUserBankApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$CreateUserBankApiStructToJson(
        CreateUserBankApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };
