// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AllowedWithdrawalType.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllowedWithdrawalType _$AllowedWithdrawalTypeFromJson(
        Map<String, dynamic> json) =>
    AllowedWithdrawalType(
      id: (json['id'] as num?)?.toInt(),
      serviceId: (json['serviceId'] as num?)?.toInt(),
      walletId: (json['walletId'] as num?)?.toInt(),
      isActive: json['isActive'] as bool?,
      serviceName: json['serviceName'] as String?,
    );

Map<String, dynamic> _$AllowedWithdrawalTypeToJson(
        AllowedWithdrawalType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serviceId': instance.serviceId,
      'walletId': instance.walletId,
      'isActive': instance.isActive,
      'serviceName': instance.serviceName,
    };
