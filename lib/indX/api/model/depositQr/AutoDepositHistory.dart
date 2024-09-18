import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';

part 'AutoDepositHistory.g.dart';

@JsonSerializable()
class AutoDepositHistory extends BasicResponse {
  @JsonKey(name: "tid")
  int? tid;
  @JsonKey(name: "transactionID")
  String? transactionID;
  @JsonKey(name: "reqAmount")
  double? reqAmount;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "currencyName")
  String? currencyName;
  @JsonKey(name: "txnHash")
  String? txnHash;
  @JsonKey(name: "entryDate")
  String? entryDate;


  AutoDepositHistory(
      {this.tid,
      this.transactionID,
      this.reqAmount,
      this.status,
      this.currencyName,
      this.txnHash,
      this.entryDate});

  factory AutoDepositHistory.fromJson(Map<String, dynamic> json) =>
      _$AutoDepositHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$AutoDepositHistoryToJson(this);
}
