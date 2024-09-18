// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enableAuth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnableAuthApiStruct _$EnableAuthApiStructFromJson(Map<String, dynamic> json) =>
    EnableAuthApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$EnableAuthApiStructToJson(
        EnableAuthApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

MasterAuthStruct _$MasterAuthStructFromJson(Map<String, dynamic> json) =>
    MasterAuthStruct(
      uniqueId: json['uniqueId'] as String?,
      active: json['active'] as bool?,
      type: json['type'] as String?,
      isEmailReq: json['isEmailReq'] as bool?,
      isgAuthReq: json['isgAuthReq'] as bool?,
      isSmsReq: json['isSmsReq'] as bool?,
    );

Map<String, dynamic> _$MasterAuthStructToJson(MasterAuthStruct instance) =>
    <String, dynamic>{
      'isEmailReq': instance.isEmailReq,
      'isSmsReq': instance.isSmsReq,
      'isgAuthReq': instance.isgAuthReq,
      'type': instance.type,
      'uniqueId': instance.uniqueId,
      'active': instance.active,
    };
