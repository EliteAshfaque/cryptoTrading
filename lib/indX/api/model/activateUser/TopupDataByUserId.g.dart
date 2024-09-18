// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TopupDataByUserId.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopupDataByUserId _$TopupDataByUserIdFromJson(Map<String, dynamic> json) =>
    TopupDataByUserId(
      oid: (json['oid'] as num?)?.toInt(),
      name: json['name'] as String?,
      walletTypeList: (json['walletTypeList'] as List<dynamic>?)
          ?.map((e) => WalletTypeList.fromJson(e as Map<String, dynamic>))
          .toList(),
      packageList: (json['packageList'] as List<dynamic>?)
          ?.map((e) => PackageList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopupDataByUserIdToJson(TopupDataByUserId instance) =>
    <String, dynamic>{
      'oid': instance.oid,
      'name': instance.name,
      'walletTypeList': instance.walletTypeList,
      'packageList': instance.packageList,
    };
