// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referral.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReferralApiStruct _$ReferralApiStructFromJson(Map<String, dynamic> json) =>
    ReferralApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$ReferralApiStructToJson(ReferralApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };
