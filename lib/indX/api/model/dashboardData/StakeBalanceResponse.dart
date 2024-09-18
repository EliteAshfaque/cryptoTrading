import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'DashboardData.dart';

part 'StakeBalanceResponse.g.dart';

@JsonSerializable()
class StakeBalanceResponse extends BasicResponse {
  @JsonKey(name: "stakeAmount")
  double? stakeAmount;
  @JsonKey(name: "amountInStakeCurr")
  double? amountInStakeCurr;
  @JsonKey(name: "symbol")
  String? symbol;
  @JsonKey(name: "stakeType")
  String? stakeType;
  @JsonKey(name: "stakeCurrID")
  int? stakeCurrID;


  StakeBalanceResponse({this.stakeAmount,this.amountInStakeCurr,this.symbol,this.stakeType,this.stakeCurrID});

  factory StakeBalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$StakeBalanceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StakeBalanceResponseToJson(this);
}
