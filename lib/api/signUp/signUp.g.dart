// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signUp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUp _$SignUpFromJson(Map<String, dynamic> json) => SignUp(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$SignUpToJson(SignUp instance) => <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

SignUpResult _$SignUpResultFromJson(Map<String, dynamic> json) => SignUpResult(
      email: json['email'] as String?,
      authType: $enumDecodeNullable(_$MasterAuthTypeEnumMap, json['authType']),
      isAdmin: json['isAdmin'] as bool?,
      name: json['name'] as String?,
      id: json['_id'] as String?,
      token: json['token'] as String?,
      uniqueLogId: json['uniqueLogId'] as String?,
      wallets:
          (json['wallets'] as List<dynamic>?)?.map((e) => e as String).toList(),
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$SignUpResultToJson(SignUpResult instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      '_id': instance.id,
      'token': instance.token,
      'uniqueLogId': instance.uniqueLogId,
      'wallets': instance.wallets,
      'isAdmin': instance.isAdmin,
      'authType': _$MasterAuthTypeEnumMap[instance.authType],
    };

const _$MasterAuthTypeEnumMap = {
  MasterAuthType.email: 'email',
  MasterAuthType.sms: 'sms',
  MasterAuthType.none: 'none',
  MasterAuthType.google_auth: 'google_auth',
};
