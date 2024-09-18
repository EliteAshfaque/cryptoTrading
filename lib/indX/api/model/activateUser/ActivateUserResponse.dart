import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';

part 'ActivateUserResponse.g.dart';

@JsonSerializable()
class ActivateUserResponse extends BasicResponse {
  @JsonKey(name: "txnHash")
  String? txnHash;
  @JsonKey(name: "fromAddress")
  String? fromAddress;
  @JsonKey(name: "toAddress")
  String? toAddress;
  @JsonKey(name: "requestAmount")
  String? requestAmount;
  @JsonKey(name: "transactionAmount")
  double? transactionAmount;
  @JsonKey(name: "amountinToWalletCurrency")
  double? amountinToWalletCurrency;
  @JsonKey(name: "toCurrencyName")
  String? toCurrencyName;
  @JsonKey(name: "requestCurrecny")
  String? requestCurrecny;
  @JsonKey(name: "stakeAmount")
  String? stakeAmount;
  @JsonKey(name: "tid")
  int? tid;
  @JsonKey(name: "lockingPeriod")
  String? lockingPeriod;
  @JsonKey(name: "monthlyMinting")
  String? monthlyMinting;
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "topupCurrID")
  int? topupCurrID;
  @JsonKey(name: "topupDate")
  String? topupDate;
  @JsonKey(name: "topUpAmount")
  double? topUpAmount;


  ActivateUserResponse(
      {this.txnHash,
      this.fromAddress,
      this.toAddress,
      this.requestAmount,
      this.transactionAmount,
      this.amountinToWalletCurrency,
      this.toCurrencyName,
      this.requestCurrecny,
      this.stakeAmount,
      this.tid,
      this.lockingPeriod,
      this.monthlyMinting,
      this.status,
      this.id,
      this.topupCurrID,
      this.topupDate,
      this.topUpAmount});

  factory ActivateUserResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivateUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ActivateUserResponseToJson(this);
}
