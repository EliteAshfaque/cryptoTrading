// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PackageList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageList _$PackageListFromJson(Map<String, dynamic> json) => PackageList(
      packageId: (json['packageId'] as num?)?.toInt(),
      packageName: json['packageName'] as String?,
      packageCost: (json['packageCost'] as num?)?.toDouble(),
      isTopup: (json['isTopup'] as num?)?.toInt(),
      rangePackageCost: (json['rangePackageCost'] as num?)?.toDouble(),
      isRangePackageCost: json['isRangePackageCost'] as bool?,
      dailyROI: json['dailyROI'] as String?,
      isRoi: json['isRoi'] as bool?,
      noOfDays: (json['noOfDays'] as num?)?.toInt(),
      remark: json['remark'] as String?,
      monthlyMint: (json['monthlyMint'] as num?)?.toDouble(),
      lockingPeriod: (json['lockingPeriod'] as num?)?.toInt(),
      packageCurrencyId: (json['packageCurrencyId'] as num?)?.toInt(),
      packageCurrency: json['packageCurrency'] as String?,
      defaultCurrency: json['defaultCurrency'] as String?,
      defaultCurrencyId: (json['defaultCurrencyId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PackageListToJson(PackageList instance) =>
    <String, dynamic>{
      'packageId': instance.packageId,
      'packageName': instance.packageName,
      'packageCost': instance.packageCost,
      'isTopup': instance.isTopup,
      'rangePackageCost': instance.rangePackageCost,
      'isRangePackageCost': instance.isRangePackageCost,
      'dailyROI': instance.dailyROI,
      'isRoi': instance.isRoi,
      'noOfDays': instance.noOfDays,
      'remark': instance.remark,
      'monthlyMint': instance.monthlyMint,
      'lockingPeriod': instance.lockingPeriod,
      'packageCurrencyId': instance.packageCurrencyId,
      'packageCurrency': instance.packageCurrency,
      'defaultCurrency': instance.defaultCurrency,
      'defaultCurrencyId': instance.defaultCurrencyId,
    };
