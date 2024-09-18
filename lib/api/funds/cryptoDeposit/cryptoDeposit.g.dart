// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cryptoDeposit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoDepositApiStruct _$CryptoDepositApiStructFromJson(
        Map<String, dynamic> json) =>
    CryptoDepositApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$CryptoDepositApiStructToJson(
        CryptoDepositApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };
