// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allMasterAuth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllMasterAuthApiStruct _$AllMasterAuthApiStructFromJson(
        Map<String, dynamic> json) =>
    AllMasterAuthApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$AllMasterAuthApiStructToJson(
        AllMasterAuthApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

DummyMasterAuthStruct _$DummyMasterAuthStructFromJson(
        Map<String, dynamic> json) =>
    DummyMasterAuthStruct(
      email: json['email'] as bool?,
      none: json['none'] as bool?,
      sms: json['sms'] as bool?,
      googleAuth: json['google_auth'] as bool?,
    );

Map<String, dynamic> _$DummyMasterAuthStructToJson(
        DummyMasterAuthStruct instance) =>
    <String, dynamic>{
      'google_auth': instance.googleAuth,
      'email': instance.email,
      'sms': instance.sms,
      'none': instance.none,
    };
