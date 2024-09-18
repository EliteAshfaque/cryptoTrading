// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TeamRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamRequest _$TeamRequestFromJson(Map<String, dynamic> json) => TeamRequest(
      FromDate: json['FromDate'] as String?,
      ToDate: json['ToDate'] as String?,
      Leg: json['Leg'] as String?,
      LevelNo: json['LevelNo'] as String?,
      Status: json['Status'] as String?,
    );

Map<String, dynamic> _$TeamRequestToJson(TeamRequest instance) =>
    <String, dynamic>{
      'FromDate': instance.FromDate,
      'ToDate': instance.ToDate,
      'Leg': instance.Leg,
      'LevelNo': instance.LevelNo,
      'Status': instance.Status,
    };
