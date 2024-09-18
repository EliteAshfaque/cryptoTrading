import 'package:json_annotation/json_annotation.dart';

import 'StakingDetailData.dart';

part 'WithdrawlMintResponse.g.dart';

@JsonSerializable()
class WithdrawlMintResponse {

  @JsonKey(name: "statuscode")
  int? statuscode;
  @JsonKey(name: "msg")
  String? msg;
  @JsonKey(name: "userID")
  int? userID;
  @JsonKey(name: "withdrawlabelMint")
  double? withdrawlabelMint;
  @JsonKey(name: "stackingDetailList")
  List<StakingDetailData>? stackingDetailList;


  WithdrawlMintResponse(
      this.statuscode, this.msg, this.userID, this.withdrawlabelMint, this.stackingDetailList);

  factory WithdrawlMintResponse.fromJson(Map<String, dynamic> json) =>
      _$WithdrawlMintResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawlMintResponseToJson(this);
}
