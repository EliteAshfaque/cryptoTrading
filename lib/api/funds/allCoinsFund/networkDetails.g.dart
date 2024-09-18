// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'networkDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkDetails _$NetworkDetailsFromJson(Map<String, dynamic> json) =>
    NetworkDetails(
      id: json['_id'] as String?,
      symbol: json['symbol'] as String?,
      techSymbol: json['techSymbol'] as String?,
      uniqueId: json['uniqueId'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      contractAddress: json['contractAddress'] as String?,
      decimals: (json['decimals'] as num?)?.toInt(),
      network: json['network'] as String?,
    );

Map<String, dynamic> _$NetworkDetailsToJson(NetworkDetails instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'symbol': instance.symbol,
      'techSymbol': instance.techSymbol,
      'uniqueId': instance.uniqueId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'contractAddress': instance.contractAddress,
      'decimals': instance.decimals,
      'network': instance.network,
    };
