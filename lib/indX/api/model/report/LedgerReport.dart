import 'package:json_annotation/json_annotation.dart';
part 'LedgerReport.g.dart';
@JsonSerializable()
class LedgerReport {

  @JsonKey(name: "tid")
  String? tid;
  @JsonKey(name: "remark")
  String? remark;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "mobileNo")
  String? mobileNo;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "serviceID")
  int? serviceID;
  @JsonKey(name: "lastAmount")
  double? lastAmount;
  @JsonKey(name: "curentBalance")
  double? curentBalance;
  @JsonKey(name: "credit")
  double? credit;
  @JsonKey(name: "debit")
  double? debit;
  @JsonKey(name: "topRows")
  int? topRows;
  @JsonKey(name: "lType")
  bool? lType;
  @JsonKey(name: "user")
  String? user;
  @JsonKey(name: "userID")
  String? userID;
  @JsonKey(name: "entryDate")
  String? entryDate;


  LedgerReport(
      {this.tid,
      this.remark,
      this.description,
      this.mobileNo,
      this.id,
      this.serviceID,
      this.lastAmount,
      this.curentBalance,
      this.credit,
      this.debit,
      this.topRows,
      this.lType,
      this.user,
      this.userID,
      this.entryDate});

  factory LedgerReport.fromJson(Map<String, dynamic> json) =>
      _$LedgerReportFromJson(json);

  Map<String, dynamic> toJson() => _$LedgerReportToJson(this);
}
