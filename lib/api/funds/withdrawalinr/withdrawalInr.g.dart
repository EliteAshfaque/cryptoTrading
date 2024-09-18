// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawalInr.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawalInrApiStruct _$WithdrawalInrApiStructFromJson(
        Map<String, dynamic> json) =>
    WithdrawalInrApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$WithdrawalInrApiStructToJson(
        WithdrawalInrApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

WithdrawalInrResp _$WithdrawalInrRespFromJson(Map<String, dynamic> json) =>
    WithdrawalInrResp(
      status: json['status'] as String?,
      authType: (json['authType'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$WithdrawalInrRespToJson(WithdrawalInrResp instance) =>
    <String, dynamic>{
      'authType': instance.authType,
      'status': instance.status,
    };
