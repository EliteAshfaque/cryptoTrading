import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';

part 'StakeHistory.g.dart';

@JsonSerializable()
class StakeHistory  {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "userID")
  int? userID;
  @JsonKey(name: "stakeCurrID")
  int? stakeCurrID;
  @JsonKey(name: "totalRoiDays")
  int? totalRoiDays;
  @JsonKey(name: "tenure")
  int? tenure;
  @JsonKey(name: "roiRate")
  double? roiRate;
  @JsonKey(name: "amountInStakeCurr")
  double? amountInStakeCurr;
  @JsonKey(name: "stakeAmount")
  double? stakeAmount;
  @JsonKey(name: "symbol")
  String? symbol;
  @JsonKey(name: "entryDate")
  String? entryDate;


  StakeHistory(
      {this.id,
      this.userID,
      this.stakeCurrID,
      this.totalRoiDays,
      this.tenure,
      this.roiRate,
      this.amountInStakeCurr,
      this.stakeAmount,
      this.symbol,
      this.entryDate});

  factory StakeHistory.fromJson(Map<String, dynamic> json) =>
      _$StakeHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$StakeHistoryToJson(this);
}
