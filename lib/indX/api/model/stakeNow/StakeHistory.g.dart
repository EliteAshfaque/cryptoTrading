// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StakeHistory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StakeHistory _$StakeHistoryFromJson(Map<String, dynamic> json) => StakeHistory(
      id: (json['id'] as num?)?.toInt(),
      userID: (json['userID'] as num?)?.toInt(),
      stakeCurrID: (json['stakeCurrID'] as num?)?.toInt(),
      totalRoiDays: (json['totalRoiDays'] as num?)?.toInt(),
      tenure: (json['tenure'] as num?)?.toInt(),
      roiRate: (json['roiRate'] as num?)?.toDouble(),
      amountInStakeCurr: (json['amountInStakeCurr'] as num?)?.toDouble(),
      stakeAmount: (json['stakeAmount'] as num?)?.toDouble(),
      symbol: json['symbol'] as String?,
      entryDate: json['entryDate'] as String?,
    );

Map<String, dynamic> _$StakeHistoryToJson(StakeHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'stakeCurrID': instance.stakeCurrID,
      'totalRoiDays': instance.totalRoiDays,
      'tenure': instance.tenure,
      'roiRate': instance.roiRate,
      'amountInStakeCurr': instance.amountInStakeCurr,
      'stakeAmount': instance.stakeAmount,
      'symbol': instance.symbol,
      'entryDate': instance.entryDate,
    };
