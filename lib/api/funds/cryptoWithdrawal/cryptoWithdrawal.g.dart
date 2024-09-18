// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cryptoWithdrawal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoWithdrawalApiStruct _$CryptoWithdrawalApiStructFromJson(
        Map<String, dynamic> json) =>
    CryptoWithdrawalApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$CryptoWithdrawalApiStructToJson(
        CryptoWithdrawalApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };
