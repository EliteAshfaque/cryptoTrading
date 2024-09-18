import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';

part 'StakeNowRequest.g.dart';

@JsonSerializable()
class StakeNowRequest {
  @JsonKey(name: "Amount")
  String? Amount;
  @JsonKey(name: "stakeCurrID")
  int? stakeCurrID;
  @JsonKey(name: "TopupUserId")
  String? TopupUserId;
  @JsonKey(name: "WalletId")
  int? WalletId;
  @JsonKey(name: "PackageID")
  int? PackageID;
  @JsonKey(name: "BusinessType")
  int? BusinessType;
  @JsonKey(name: "PackageAmount")
  String? PackageAmount;
  @JsonKey(name: "FromCurrencyId")
  int? FromCurrencyId;
  @JsonKey(name: "StakeType")
  int? StakeType;


  StakeNowRequest(
      {this.Amount,
      this.stakeCurrID,
      this.TopupUserId,
      this.WalletId,
      this.PackageID,
      this.BusinessType,
      this.PackageAmount,
      this.FromCurrencyId,
      this.StakeType});

  factory StakeNowRequest.fromJson(Map<String, dynamic> json) =>
      _$StakeNowRequestFromJson(json);

  Map<String, dynamic> toJson() => _$StakeNowRequestToJson(this);
}
