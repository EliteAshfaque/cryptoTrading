// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allCoins.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllCoins _$AllCoinsFromJson(Map<String, dynamic> json) => AllCoins(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$AllCoinsToJson(AllCoins instance) => <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

CoinListings _$CoinListingsFromJson(Map<String, dynamic> json) => CoinListings(
      status: json['status'] as String?,
      askPrice: (json['askPrice'] as num?)?.toDouble(),
      bidPrice: (json['bidPrice'] as num?)?.toDouble(),
      canDeposit: json['canDeposit'] as bool?,
      canWithdrawal: json['canWithdrawal'] as bool?,
      closePrice: (json['closePrice'] as num?)?.toDouble(),
      contractAddress: json['contractAddress'] as String?,
      highPrice: (json['highPrice'] as num?)?.toDouble(),
      imgUrl: json['imgUrl'] as String?,
      lowPrice: (json['lowPrice'] as num?)?.toDouble(),
      network: json['network'] as String?,
      openPrice: (json['openPrice'] as num?)?.toDouble(),
      percentageChange: json['percentageChange'] as String?,
      symbol: json['symbol'] as String?,
      updatedAt: (json['updatedAt'] as num?)?.toInt(),
      ticker: json['ticker'] as String? ?? "up",
      volume: json['volume'] as String?,
      quoteVolume: json['quoteVolume'] as String?,
      listed: (json['listed'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CoinListingsToJson(CoinListings instance) =>
    <String, dynamic>{
      'updatedAt': instance.updatedAt,
      'symbol': instance.symbol,
      'openPrice': instance.openPrice,
      'closePrice': instance.closePrice,
      'askPrice': instance.askPrice,
      'bidPrice': instance.bidPrice,
      'lowPrice': instance.lowPrice,
      'highPrice': instance.highPrice,
      'status': instance.status,
      'contractAddress': instance.contractAddress,
      'network': instance.network,
      'canDeposit': instance.canDeposit,
      'canWithdrawal': instance.canWithdrawal,
      'imgUrl': instance.imgUrl,
      'percentageChange': instance.percentageChange,
      'quoteVolume': instance.quoteVolume,
      'volume': instance.volume,
      'listed': instance.listed,
      'ticker': instance.ticker,
    };
