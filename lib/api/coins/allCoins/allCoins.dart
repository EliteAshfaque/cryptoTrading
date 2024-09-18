import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'allCoins.g.dart';

@JsonSerializable()
class AllCoins extends Base {

  AllCoins({required bool success}) : super(result: Result(message: List<CoinListings>), success: success);

  factory AllCoins.fromJson(Map<String, dynamic> json) =>  _$AllCoinsFromJson(json);
  Map<String, dynamic> toJson() => _$AllCoinsToJson(this);
}

@JsonSerializable()
class CoinListings {

  @JsonKey(name:"updatedAt")
  int? updatedAt;

  @JsonKey(name:"symbol")
  String? symbol;

  @JsonKey(name:"openPrice")
  double? openPrice;

  @JsonKey(name:"closePrice")
  double? closePrice;

  @JsonKey(name:"askPrice")
  double? askPrice;

  @JsonKey(name:"bidPrice")
  double? bidPrice;

  @JsonKey(name:"lowPrice")
  double? lowPrice;

  @JsonKey(name:"highPrice")
  double? highPrice;

  @JsonKey(name:"status")
  String? status;

  @JsonKey(name:"contractAddress")
  String? contractAddress;

  @JsonKey(name:"network")
  String? network;

  @JsonKey(name:"canDeposit")
  bool? canDeposit;

  @JsonKey(name:"canWithdrawal")
  bool? canWithdrawal;

  @JsonKey(name:"imgUrl")
  String? imgUrl;

  @JsonKey(name:"percentageChange")
  String? percentageChange;

  @JsonKey(name:"quoteVolume")
  String? quoteVolume;

  @JsonKey(name:"volume")
  String? volume;

  @JsonKey(name:"listed")
  int? listed;

  String? ticker;

  CoinListings({this.status, this.askPrice, this.bidPrice, this.canDeposit, this.canWithdrawal, this.closePrice,
    this.contractAddress, this.highPrice, this.imgUrl, this.lowPrice, this.network, this.openPrice,
  this.percentageChange, this.symbol, this.updatedAt, this.ticker = "up", this.volume, this.quoteVolume,
  this.listed});

  factory CoinListings.fromJson(Map<String, dynamic> json) =>  _$CoinListingsFromJson(json);
  Map<String, dynamic> toJson() => _$CoinListingsToJson(this);

}