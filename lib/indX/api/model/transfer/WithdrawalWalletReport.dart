import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';

part 'WithdrawalWalletReport.g.dart';

@JsonSerializable()
class WithdrawalWalletReport {

  @JsonKey(name: "tid")
  int? tid;
  @JsonKey(name: "userId")
  int? userId;
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "userName")
  String? userName;
  @JsonKey(name: "requestedAmount")
  double? requestedAmount;
  @JsonKey(name: "fromCurrencyName")
  String? fromCurrencyName;
  @JsonKey(name: "toCurrencyName")
  String? toCurrencyName;
  @JsonKey(name: "toWallet")
  String? toWallet;
  @JsonKey(name: "convsertionRate")
  double? convsertionRate;
  @JsonKey(name: "liveRate")
  double? liveRate;
  @JsonKey(name: "transferAmount")
  double? transferAmount;
  @JsonKey(name: "liveId")
  String? liveId;
  @JsonKey(name: "entryDate")
  String? entryDate;
  @JsonKey(name: "toAddress")
  String? toAddress;


  WithdrawalWalletReport(
      {this.tid,
      this.userId,
      this.status,
      this.userName,
      this.requestedAmount,
      this.fromCurrencyName,
      this.toCurrencyName,
      this.toWallet,
      this.convsertionRate,
      this.liveRate,
      this.transferAmount,
      this.liveId,
      this.entryDate,
      this.toAddress});

  factory WithdrawalWalletReport.fromJson(Map<String, dynamic> json) =>
      _$WithdrawalWalletReportFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawalWalletReportToJson(this);
}
