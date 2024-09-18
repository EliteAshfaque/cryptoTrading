// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getMasterCoinList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMasterCoinListApiStruct _$GetMasterCoinListApiStructFromJson(
        Map<String, dynamic> json) =>
    GetMasterCoinListApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$GetMasterCoinListApiStructToJson(
        GetMasterCoinListApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

MasterCoinListingsStruct _$MasterCoinListingsStructFromJson(
        Map<String, dynamic> json) =>
    MasterCoinListingsStruct(
      updatedAt: json['updatedAt'] as String?,
      createdAt: json['createdAt'] as String?,
      symbol: json['symbol'] as String?,
      symbolName: json['symbolName'] as String?,
      id: json['_id'] as String?,
      imgUrl: json['imgUrl'] as String?,
      listed: (json['listed'] as num?)?.toInt(),
      status: json['status'] as String?,
      network: (json['network'] as List<dynamic>?)
          ?.map((e) => NetworkDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      canDeposit: json['canDeposit'] as bool?,
      canWithdrawal: json['canWithdrawal'] as bool?,
      activeDed: json['activeDed'] as String?,
      adminApproval: json['adminApproval'] as bool?,
      dedAmount: json['dedAmount'] as String?,
      dedPercentage: json['dedPercentage'] as String?,
      depositFee: json['depositFee'] as String?,
      displayName: json['displayName'] as String?,
      maxDeposit: json['maxDeposit'] as String?,
      maxWithdrawal: json['maxWithdrawal'] as String?,
      minDeposit: json['minDeposit'] as String?,
      minWithdrawal: json['minWithdrawal'] as String?,
      withdrawalFee: json['withdrawalFee'] as String?,
    );

Map<String, dynamic> _$MasterCoinListingsStructToJson(
        MasterCoinListingsStruct instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'symbol': instance.symbol,
      'symbolName': instance.symbolName,
      'status': instance.status,
      'network': instance.network,
      'canDeposit': instance.canDeposit,
      'canWithdrawal': instance.canWithdrawal,
      'imgUrl': instance.imgUrl,
      'minDeposit': instance.minDeposit,
      'maxDeposit': instance.maxDeposit,
      'minWithdrawal': instance.minWithdrawal,
      'maxWithdrawal': instance.maxWithdrawal,
      'displayName': instance.displayName,
      'listed': instance.listed,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'depositFee': instance.depositFee,
      'withdrawalFee': instance.withdrawalFee,
      'adminApproval': instance.adminApproval,
      'dedPercentage': instance.dedPercentage,
      'dedAmount': instance.dedAmount,
      'activeDed': instance.activeDed,
    };
