// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userWallets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWalletStruct _$UserWalletStructFromJson(Map<String, dynamic> json) =>
    UserWalletStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$UserWalletStructToJson(UserWalletStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      createdAt: (json['createdAt'] as num?)?.toInt(),
      updatedAt: json['updatedAt'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String? ?? "",
      active: json['active'] as bool?,
      actualBalance: json['actualBalance'] as String?,
      balance: json['balance'] as String?,
      currency: json['currency'] as String?,
      freezeAmount: json['freezeAmount'] as String?,
      maxAmount: (json['maxAmount'] as num?)?.toInt(),
      minAmount: (json['minAmount'] as num?)?.toInt(),
      type: json['type'] as String?,
      uniqueId: json['uniqueId'] as String?,
      total: (json['total'] as num?)?.toDouble(),
      listedPair: json['listedPair'] as String?,
      symbolName: json['symbolName'] as String?,
      network: (json['network'] as List<dynamic>?)
          ?.map((e) => NetworkDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      canDeposit: json['canDeposit'] as bool?,
      canWithdrawal: json['canWithdrawal'] as bool?,
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'active': instance.active,
      'actualBalance': instance.actualBalance,
      'balance': instance.balance,
      'createdAt': instance.createdAt,
      'currency': instance.currency,
      'email': instance.email,
      'freezeAmount': instance.freezeAmount,
      'maxAmount': instance.maxAmount,
      'minAmount': instance.minAmount,
      'type': instance.type,
      'uniqueId': instance.uniqueId,
      'updatedAt': instance.updatedAt,
      'name': instance.name,
      'listedPair': instance.listedPair,
      'total': instance.total,
      'symbolName': instance.symbolName,
      'network': instance.network,
      'canDeposit': instance.canDeposit,
      'canWithdrawal': instance.canWithdrawal,
    };
