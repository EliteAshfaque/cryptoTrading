// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bankList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankListApiStruct _$BankListApiStructFromJson(Map<String, dynamic> json) =>
    BankListApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$BankListApiStructToJson(BankListApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

BankListStruct _$BankListStructFromJson(Map<String, dynamic> json) =>
    BankListStruct(
      bankName: json['bankName'] as String?,
      ifsc: json['ifsc'] as String?,
      createdAt: json['createdAt'] as String?,
      bankId: json['bankId'] as String?,
    );

Map<String, dynamic> _$BankListStructToJson(BankListStruct instance) =>
    <String, dynamic>{
      'bankId': instance.bankId,
      'bankName': instance.bankName,
      'ifsc': instance.ifsc,
      'createdAt': instance.createdAt,
    };
