import 'package:json_annotation/json_annotation.dart';


part 'FundRequestReport.g.dart';

@JsonSerializable()
class FundRequestReport {


  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "bank")
  String? bank;
  @JsonKey(name: "accountNo")
  String? accountNo;
  @JsonKey(name: "transactionId")
  String? transactionId;
  @JsonKey(name: "accountHolder")
  String? accountHolder;
  @JsonKey(name: "entryDate")
  String? entryDate;
  @JsonKey(name: "amount")
  double? amount;
  @JsonKey(name: "approveDate")
  String? approveDate;


  FundRequestReport(
      {this.status,
        this.bank,
      this.accountNo,
      this.transactionId,
      this.accountHolder,
      this.entryDate,
      this.amount,
      this.approveDate});

  factory FundRequestReport.fromJson(Map<String, dynamic> json) =>
      _$FundRequestReportFromJson(json);

  Map<String, dynamic> toJson() => _$FundRequestReportToJson(this);
}
