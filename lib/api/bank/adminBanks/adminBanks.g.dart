// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adminBanks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminBanksApiStruct _$AdminBanksApiStructFromJson(Map<String, dynamic> json) =>
    AdminBanksApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$AdminBanksApiStructToJson(
        AdminBanksApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

AdminBanksStruct _$AdminBanksStructFromJson(Map<String, dynamic> json) =>
    AdminBanksStruct(
      createdAt: (json['createdAt'] as num?)?.toInt(),
      status: json['status'] as String?,
      email: json['email'] as String?,
      accNumber: json['accNumber'] as String?,
      bankName: json['bankName'] as String?,
      ifsc: json['ifsc'] as String?,
      accHolderName: json['accHolderName'] as String?,
      paymentModes: (json['paymentModes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$AdminBanksStructToJson(AdminBanksStruct instance) =>
    <String, dynamic>{
      'status': instance.status,
      'paymentModes': instance.paymentModes,
      'bankName': instance.bankName,
      'email': instance.email,
      'accHolderName': instance.accHolderName,
      'createdAt': instance.createdAt,
      'ifsc': instance.ifsc,
      'accNumber': instance.accNumber,
      '_id': instance.id,
    };
