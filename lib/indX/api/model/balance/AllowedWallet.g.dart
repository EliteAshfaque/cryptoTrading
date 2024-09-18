// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AllowedWallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllowedWallet _$AllowedWalletFromJson(Map<String, dynamic> json) =>
    AllowedWallet(
      id: (json['id'] as num?)?.toInt(),
      fromWallet: (json['fromWallet'] as num?)?.toInt(),
      fromWalletId: (json['fromWalletId'] as num?)?.toInt(),
      toWalletId: (json['toWalletId'] as num?)?.toInt(),
      isActive: json['isActive'] as bool?,
      toWalletName: json['toWalletName'] as String?,
      fromWalletName: json['fromWalletName'] as String?,
      walletName: json['walletName'] as String?,
    );

Map<String, dynamic> _$AllowedWalletToJson(AllowedWallet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fromWallet': instance.fromWallet,
      'fromWalletId': instance.fromWalletId,
      'toWalletId': instance.toWalletId,
      'isActive': instance.isActive,
      'toWalletName': instance.toWalletName,
      'fromWalletName': instance.fromWalletName,
      'walletName': instance.walletName,
    };
