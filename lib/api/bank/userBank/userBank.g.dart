// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userBank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBankApiStruct _$UserBankApiStructFromJson(Map<String, dynamic> json) =>
    UserBankApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$UserBankApiStructToJson(UserBankApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

UserBankStruct _$UserBankStructFromJson(Map<String, dynamic> json) =>
    UserBankStruct(
      uniqueId: json['uniqueId'] as String?,
      email: json['email'] as String?,
      createdAt: json['createdAt'] as String?,
      status: json['status'] as String?,
      utrNo: json['utrNo'] as String?,
      active: json['active'] as bool?,
      accHolderName: json['accHolderName'] as String?,
      accNumber: json['accNumber'] as String?,
      bankName: json['bankName'] as String?,
      ifsc: json['ifsc'] as String?,
    );

Map<String, dynamic> _$UserBankStructToJson(UserBankStruct instance) =>
    <String, dynamic>{
      'active': instance.active,
      'accNumber': instance.accNumber,
      'email': instance.email,
      'accHolderName': instance.accHolderName,
      'bankName': instance.bankName,
      'createdAt': instance.createdAt,
      'ifsc': instance.ifsc,
      'status': instance.status,
      'uniqueId': instance.uniqueId,
      'utrNo': instance.utrNo,
    };
