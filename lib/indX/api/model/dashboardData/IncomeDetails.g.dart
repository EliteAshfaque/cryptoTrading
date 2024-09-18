// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IncomeDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncomeDetails _$IncomeDetailsFromJson(Map<String, dynamic> json) =>
    IncomeDetails(
      incomeOPID: (json['incomeOPID'] as num?)?.toInt(),
      incomeFigure: (json['incomeFigure'] as num?)?.toDouble(),
      incomeAfterTax: (json['incomeAfterTax'] as num?)?.toDouble(),
      incomeName: json['incomeName'] as String?,
      incomeCategoryID: (json['incomeCategoryID'] as num?)?.toInt(),
      incomeCategoryName: json['incomeCategoryName'] as String?,
    );

Map<String, dynamic> _$IncomeDetailsToJson(IncomeDetails instance) =>
    <String, dynamic>{
      'incomeOPID': instance.incomeOPID,
      'incomeFigure': instance.incomeFigure,
      'incomeAfterTax': instance.incomeAfterTax,
      'incomeName': instance.incomeName,
      'incomeCategoryID': instance.incomeCategoryID,
      'incomeCategoryName': instance.incomeCategoryName,
    };
