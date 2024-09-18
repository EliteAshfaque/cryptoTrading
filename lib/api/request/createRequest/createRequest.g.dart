// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'createRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateRequestApiStruct _$CreateRequestApiStructFromJson(
        Map<String, dynamic> json) =>
    CreateRequestApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$CreateRequestApiStructToJson(
        CreateRequestApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

FiatRequestStruct _$FiatRequestStructFromJson(Map<String, dynamic> json) =>
    FiatRequestStruct(
      createdAt: (json['createdAt'] as num?)?.toInt(),
      status: json['status'] as String?,
      email: json['email'] as String?,
      bankId: json['bankId'] as String?,
      utrNo: json['utrNo'] as String?,
      failedReason: json['failedReason'] as String?,
      uniqueId: json['uniqueId'] as String?,
      balance: (json['balance'] as num?)?.toInt(),
      walletId: json['walletId'] as String?,
      paymentMode: json['paymentMode'] as String?,
      docId: json['docId'] as String?,
    );

Map<String, dynamic> _$FiatRequestStructToJson(FiatRequestStruct instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'email': instance.email,
      'balance': instance.balance,
      'status': instance.status,
      'uniqueId': instance.uniqueId,
      'walletId': instance.walletId,
      'utrNo': instance.utrNo,
      'bankId': instance.bankId,
      'paymentMode': instance.paymentMode,
      'docId': instance.docId,
      'failedReason': instance.failedReason,
    };
