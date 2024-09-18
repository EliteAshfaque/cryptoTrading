// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AllowedWalletToCrypto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllowedWalletToCrypto _$AllowedWalletToCryptoFromJson(
        Map<String, dynamic> json) =>
    AllowedWalletToCrypto(
      symbolId: (json['symbolId'] as num?)?.toInt(),
      walletId: (json['walletId'] as num?)?.toInt(),
      isActive: json['isActive'] as bool?,
      symbolName: json['symbolName'] as String?,
      image: json['image'] as String?,
      isdoubbleFactor: json['isdoubbleFactor'] as bool?,
      isExternalAddress: json['isExternalAddress'] as bool?,
    );

Map<String, dynamic> _$AllowedWalletToCryptoToJson(
        AllowedWalletToCrypto instance) =>
    <String, dynamic>{
      'symbolId': instance.symbolId,
      'walletId': instance.walletId,
      'isActive': instance.isActive,
      'symbolName': instance.symbolName,
      'image': instance.image,
      'isdoubbleFactor': instance.isdoubbleFactor,
      'isExternalAddress': instance.isExternalAddress,
    };
