// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allCoinsFund.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllCoinsFundApiStruct _$AllCoinsFundApiStructFromJson(
        Map<String, dynamic> json) =>
    AllCoinsFundApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$AllCoinsFundApiStructToJson(
        AllCoinsFundApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

FundsDummyStruct _$FundsDummyStructFromJson(Map<String, dynamic> json) =>
    FundsDummyStruct(
      allFunds: (json['allFunds'] as List<dynamic>?)
          ?.map((e) => FundsStruct.fromJson(e as Map<String, dynamic>))
          .toList(),
      userInrWallet: json['userInrWallet'] == null
          ? null
          : UserInrWalletStruct.fromJson(
              json['userInrWallet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FundsDummyStructToJson(FundsDummyStruct instance) =>
    <String, dynamic>{
      'allFunds': instance.allFunds,
      'userInrWallet': instance.userInrWallet,
    };

UserInrWalletStruct _$UserInrWalletStructFromJson(Map<String, dynamic> json) =>
    UserInrWalletStruct(
      balance: json['balance'] as String?,
      email: json['email'] as String?,
      uniqueId: json['uniqueId'] as String?,
      currency: json['currency'] as String?,
      createdAt: (json['createdAt'] as num?)?.toInt(),
      type: json['type'] as String?,
      active: json['active'] as bool?,
      freezeAmount: json['freezeAmount'] as String?,
      actualBalance: json['actualBalance'] as String?,
    );

Map<String, dynamic> _$UserInrWalletStructToJson(
        UserInrWalletStruct instance) =>
    <String, dynamic>{
      'active': instance.active,
      'actualBalance': instance.actualBalance,
      'balance': instance.balance,
      'createdAt': instance.createdAt,
      'currency': instance.currency,
      'email': instance.email,
      'freezeAmount': instance.freezeAmount,
      'type': instance.type,
      'uniqueId': instance.uniqueId,
    };

FundsStruct _$FundsStructFromJson(Map<String, dynamic> json) => FundsStruct(
      symbol: json['symbol'] as String?,
      symbolName: json['symbolName'] as String?,
      balance: json['balance'] as String?,
      canDeposit: json['canDeposit'] as bool?,
      canWithdrawal: json['canWithdrawal'] as bool?,
      listed: (json['listed'] as num?)?.toInt(),
      networkDetails: (json['networkDetails'] as List<dynamic>?)
          ?.map((e) => NetworkDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FundsStructToJson(FundsStruct instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'canDeposit': instance.canDeposit,
      'canWithdrawal': instance.canWithdrawal,
      'symbol': instance.symbol,
      'symbolName': instance.symbolName,
      'listed': instance.listed,
      'networkDetails': instance.networkDetails,
    };
