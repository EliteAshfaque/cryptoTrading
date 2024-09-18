// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserDetailRank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailRank _$UserDetailRankFromJson(Map<String, dynamic> json) =>
    UserDetailRank(
      rankName: json['rankName'] as String?,
      rankImage: json['rankImage'] as String?,
      bussinessCurrSymbol: json['bussinessCurrSymbol'] as String?,
      bussinessCurrImage: json['bussinessCurrImage'] as String?,
      bussinessCurrName: json['bussinessCurrName'] as String?,
      bussinessCurrId: (json['bussinessCurrId'] as num?)?.toInt(),
      toupAmount: (json['toupAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UserDetailRankToJson(UserDetailRank instance) =>
    <String, dynamic>{
      'rankName': instance.rankName,
      'rankImage': instance.rankImage,
      'bussinessCurrSymbol': instance.bussinessCurrSymbol,
      'bussinessCurrImage': instance.bussinessCurrImage,
      'bussinessCurrName': instance.bussinessCurrName,
      'bussinessCurrId': instance.bussinessCurrId,
      'toupAmount': instance.toupAmount,
    };
