// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AllowTransferMapping.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllowTransferMapping _$AllowTransferMappingFromJson(
        Map<String, dynamic> json) =>
    AllowTransferMapping(
      serviceId: (json['serviceId'] as num?)?.toInt(),
      serviceName: json['serviceName'] as String?,
      currencyId: (json['currencyId'] as num?)?.toInt(),
      currencyName: json['currencyName'] as String?,
      currencySymbol: json['currencySymbol'] as String?,
    );

Map<String, dynamic> _$AllowTransferMappingToJson(
        AllowTransferMapping instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
      'serviceName': instance.serviceName,
      'currencyId': instance.currencyId,
      'currencyName': instance.currencyName,
      'currencySymbol': instance.currencySymbol,
    };
