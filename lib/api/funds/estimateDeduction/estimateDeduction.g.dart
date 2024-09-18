// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estimateDeduction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstimateDeductionApiStruct _$EstimateDeductionApiStructFromJson(
        Map<String, dynamic> json) =>
    EstimateDeductionApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$EstimateDeductionApiStructToJson(
        EstimateDeductionApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

EstimateDeductionStruct _$EstimateDeductionStructFromJson(
        Map<String, dynamic> json) =>
    EstimateDeductionStruct(
      finalAmount: json['finalAmount'] as String?,
      afterCommission: json['afterCommission'] as String?,
      afterTds: json['afterTds'] as String?,
      tdsPercent: json['tdsPercent'] as String?,
      tdsToken: json['tdsToken'] as String?,
    );

Map<String, dynamic> _$EstimateDeductionStructToJson(
        EstimateDeductionStruct instance) =>
    <String, dynamic>{
      'afterTds': instance.afterTds,
      'afterCommission': instance.afterCommission,
      'finalAmount': instance.finalAmount,
      'tdsPercent': instance.tdsPercent,
      'tdsToken': instance.tdsToken,
    };
