// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WithdrawlMintResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawlMintResponse _$WithdrawlMintResponseFromJson(
        Map<String, dynamic> json) =>
    WithdrawlMintResponse(
      (json['statuscode'] as num?)?.toInt(),
      json['msg'] as String?,
      (json['userID'] as num?)?.toInt(),
      (json['withdrawlabelMint'] as num?)?.toDouble(),
      (json['stackingDetailList'] as List<dynamic>?)
          ?.map((e) => StakingDetailData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WithdrawlMintResponseToJson(
        WithdrawlMintResponse instance) =>
    <String, dynamic>{
      'statuscode': instance.statuscode,
      'msg': instance.msg,
      'userID': instance.userID,
      'withdrawlabelMint': instance.withdrawlabelMint,
      'stackingDetailList': instance.stackingDetailList,
    };
