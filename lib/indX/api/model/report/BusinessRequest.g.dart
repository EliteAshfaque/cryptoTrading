// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BusinessRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessRequest _$BusinessRequestFromJson(Map<String, dynamic> json) =>
    BusinessRequest(
      FromDate: json['FromDate'] as String?,
      ToDate: json['ToDate'] as String?,
      Leg: json['Leg'] as String?,
      LevelNo: json['LevelNo'] as String?,
      BusinessType: (json['BusinessType'] as num?)?.toInt(),
      SponserId: json['SponserId'] as String?,
    );

Map<String, dynamic> _$BusinessRequestToJson(BusinessRequest instance) =>
    <String, dynamic>{
      'FromDate': instance.FromDate,
      'ToDate': instance.ToDate,
      'Leg': instance.Leg,
      'LevelNo': instance.LevelNo,
      'BusinessType': instance.BusinessType,
      'SponserId': instance.SponserId,
    };
