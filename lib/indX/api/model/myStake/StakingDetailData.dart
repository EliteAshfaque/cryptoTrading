import 'package:json_annotation/json_annotation.dart';

part 'StakingDetailData.g.dart';

@JsonSerializable()
class StakingDetailData {

  @JsonKey(name: "planName")
  String? planName;
  @JsonKey(name: "amount")
  double? amount;
  @JsonKey(name: "purchaseDate")
  String? purchaseDate;
  @JsonKey(name: "withdrawalDate")
  String? withdrawalDate;
  @JsonKey(name: "lastwithdrwalDate")
  String? lastwithdrwalDate;


  StakingDetailData(
      {this.planName,
      this.amount,
      this.purchaseDate,
      this.withdrawalDate,
      this.lastwithdrwalDate});

  factory StakingDetailData.fromJson(Map<String, dynamic> json) =>
      _$StakingDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$StakingDetailDataToJson(this);
}
