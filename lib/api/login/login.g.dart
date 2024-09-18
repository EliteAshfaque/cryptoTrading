// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) => Login(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

LoginResult _$LoginResultFromJson(Map<String, dynamic> json) => LoginResult(
      email: json['email'] as String?,
      authType: $enumDecodeNullable(_$MasterAuthTypeEnumMap, json['authType']),
      isAdmin: json['isAdmin'] as bool?,
      name: json['name'] as String?,
      status: $enumDecodeNullable(_$LoginStatusEnumMap, json['status']),
      active: json['active'] as bool?,
      token: json['token'] as String?,
      uniqueLogId: json['uniqueLogId'] as String?,
      wallets:
          (json['wallets'] as List<dynamic>?)?.map((e) => e as String).toList(),
      countryCode: (json['countryCode'] as num?)?.toInt(),
      phone: json['phone'] as String?,
      isDeleteApproval: json['isDeleteApproval'] as bool?,
    );

Map<String, dynamic> _$LoginResultToJson(LoginResult instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'countryCode': instance.countryCode,
      'phone': instance.phone,
      'token': instance.token,
      'uniqueLogId': instance.uniqueLogId,
      'status': _$LoginStatusEnumMap[instance.status],
      'wallets': instance.wallets,
      'isAdmin': instance.isAdmin,
      'isDeleteApproval': instance.isDeleteApproval,
      'active': instance.active,
      'authType': _$MasterAuthTypeEnumMap[instance.authType],
    };

const _$MasterAuthTypeEnumMap = {
  MasterAuthType.email: 'email',
  MasterAuthType.sms: 'sms',
  MasterAuthType.none: 'none',
  MasterAuthType.google_auth: 'google_auth',
};

const _$LoginStatusEnumMap = {
  LoginStatus.In_Progress: 'In_Progress',
  LoginStatus.Success: 'Success',
  LoginStatus.Failed: 'Failed',
};
