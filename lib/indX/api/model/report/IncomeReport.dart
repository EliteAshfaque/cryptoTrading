import 'package:json_annotation/json_annotation.dart';
part 'IncomeReport.g.dart';
@JsonSerializable()
class IncomeReport {
  
  @JsonKey(name: "resultCode")
  int? resultCode;
  @JsonKey(name: "msg")
  String? msg;
  @JsonKey(name: "tid")
  int? tid;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "totalCreditedAmount")
  double? totalCreditedAmount;
  @JsonKey(name: "binaryIncome")
  double? binaryIncome;
  @JsonKey(name: "lapsIncome")
  String? lapsIncome;
  @JsonKey(name: "payoutDate")
  String? payoutDate;
  @JsonKey(name: "creditedAmount")
  double? creditedAmount;
  @JsonKey(name: "adminCharge")
  String? adminCharge;
  @JsonKey(name: "incomeOPID")
  String? incomeOPID;
  @JsonKey(name: "fromName")
  String? fromName;
  @JsonKey(name: "fromUserId")
  String? fromUserId;
  @JsonKey(name: "toName")
  String? toName;
  @JsonKey(name: "toUserId")
  String? toUserId;
  @JsonKey(name: "entryDate")
  String? entryDate;
  @JsonKey(name: "incomeName")
  String? incomeName;
  @JsonKey(name: "fromTeamOf")
  String? fromTeamOf;
  @JsonKey(name: "todayMatchBusiness")
  String? todayMatchBusiness;
  @JsonKey(name: "totalRightBusiness")
  String? totalRightBusiness;
  @JsonKey(name: "totalLeftBusiness")
  String? totalLeftBusiness;
  @JsonKey(name: "levelNo")
  String? levelNo;


  IncomeReport(
      {this.resultCode,
      this.msg,
      this.tid,
      this.name,
      this.totalCreditedAmount,
      this.binaryIncome,
      this.lapsIncome,
      this.payoutDate,
      this.creditedAmount,
      this.adminCharge,
      this.incomeOPID,
      this.fromName,
      this.fromUserId,
      this.toName,
      this.toUserId,
      this.entryDate,
      this.incomeName,
      this.fromTeamOf,
      this.todayMatchBusiness,
      this.totalRightBusiness,
      this.totalLeftBusiness,
      this.levelNo});

  factory IncomeReport.fromJson(Map<String, dynamic> json) =>
      _$IncomeReportFromJson(json);

  Map<String, dynamic> toJson() => _$IncomeReportToJson(this);
}
