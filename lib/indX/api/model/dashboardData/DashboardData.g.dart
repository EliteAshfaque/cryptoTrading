// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DashboardData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardData _$DashboardDataFromJson(Map<String, dynamic> json) =>
    DashboardData(
      packageExpireInDays: (json['packageExpireInDays'] as num?)?.toInt(),
      singleData: json['singleData'] == null
          ? null
          : SingleData.fromJson(json['singleData'] as Map<String, dynamic>),
      incomeDetails: (json['incomeDetails'] as List<dynamic>?)
          ?.map((e) => IncomeDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DashboardDataToJson(DashboardData instance) =>
    <String, dynamic>{
      'packageExpireInDays': instance.packageExpireInDays,
      'singleData': instance.singleData,
      'incomeDetails': instance.incomeDetails,
    };
