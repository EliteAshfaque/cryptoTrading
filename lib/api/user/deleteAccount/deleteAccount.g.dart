// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deleteAccount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteAccountApiStruct _$DeleteAccountApiStructFromJson(
        Map<String, dynamic> json) =>
    DeleteAccountApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$DeleteAccountApiStructToJson(
        DeleteAccountApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };
