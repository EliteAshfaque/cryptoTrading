import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import '../activateUser/TopupDataByUserId.dart';
import 'LiveRateData.dart';

part 'CurrencyBalanceData.g.dart';

@JsonSerializable()
class CurrencyBalanceData extends BasicResponse {
  @JsonKey(name: "balance")
  String? balance;
  @JsonKey(name: "fiatCurrSymbol")
  String? fiatCurrSymbol;
  @JsonKey(name: "balanceInUSDT")
  double? balanceInUSDT;
  @JsonKey(name: "balanceInFiat")
  double? balanceInFiat;
  @JsonKey(name: "fiatCurrID")
  int? fiatCurrID;
  @JsonKey(name: "fiatTechnologyId")
  int? fiatTechnologyId;
  @JsonKey(name: "requestedCurrID")
  int? requestedCurrID;

  CurrencyBalanceData(
      {this.balance,
      this.fiatCurrSymbol,
      this.balanceInUSDT,
      this.balanceInFiat,
      this.fiatCurrID,
      this.fiatTechnologyId,
      this.requestedCurrID});

  factory CurrencyBalanceData.fromJson(Map<String, dynamic> json) =>
      _$CurrencyBalanceDataFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyBalanceDataToJson(this);
}
