// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailsApiStruct _$UserDetailsApiStructFromJson(
        Map<String, dynamic> json) =>
    UserDetailsApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$UserDetailsApiStructToJson(
        UserDetailsApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

IUserStruct _$IUserStructFromJson(Map<String, dynamic> json) => IUserStruct(
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      kycVerified: json['kycVerified'] as bool?,
      active: json['active'] as bool?,
      canWithdrawal: json['canWithdrawal'] as bool?,
      canDeposit: json['canDeposit'] as bool?,
      authType: json['authType'] as String?,
      isAdmin: json['isAdmin'] as bool?,
      trialActivated: json['trialActivated'] as bool?,
      kycVerificationId: json['kycVerificationId'] as String?,
      lastSendEmailOtp: json['lastSendEmailOtp'] as String?,
      id: json['_id'] as String?,
      createdAt: json['createdAt'] as String?,
      uniqueId: json['uniqueId'] as String?,
    );

Map<String, dynamic> _$IUserStructToJson(IUserStruct instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'trialActivated': instance.trialActivated,
      'canWithdrawal': instance.canWithdrawal,
      'canDeposit': instance.canDeposit,
      'active': instance.active,
      'authType': instance.authType,
      'kycVerificationId': instance.kycVerificationId,
      'kycVerified': instance.kycVerified,
      'isAdmin': instance.isAdmin,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'lastSendEmailOtp': instance.lastSendEmailOtp,
      'createdAt': instance.createdAt,
      'uniqueId': instance.uniqueId,
    };
