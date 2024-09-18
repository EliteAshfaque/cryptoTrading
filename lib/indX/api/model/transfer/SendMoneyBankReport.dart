import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';

part 'SendMoneyBankReport.g.dart';

@JsonSerializable()
class SendMoneyBankReport {
  @JsonKey(name: "_Type")
  int? intType;
  @JsonKey(name: "type_")
  String? type_;
  @JsonKey(name: "refundStatus")
  int? refundStatus;
  @JsonKey(name: "refundStatus_")
  String? refundStatus_;
  @JsonKey(name: "opening")
  double? opening;
  @JsonKey(name: "outletUserMobile")
  String? outletUserMobile;
  @JsonKey(name: "outletUserCompany")
  String? outletUserCompany;
  @JsonKey(name: "senderMobile")
  String? senderMobile;
  @JsonKey(name: "groupID")
  String? groupID;
  @JsonKey(name: "ccf")
  double? ccf;
  @JsonKey(name: "surcharge")
  double? surcharge;
  @JsonKey(name: "refundGST")
  double? refundGST;
  @JsonKey(name: "amtWithTDS")
  double? amtWithTDS;
  @JsonKey(name: "credited_Amount")
  double? creditedAmount;
  @JsonKey(name: "ccName")
  String? ccName;
  @JsonKey(name: "ccMobileNo")
  String? ccMobileNo;
  @JsonKey(name: "_ServiceID")
  int? serviceID;
  @JsonKey(name: "tid")
  int? tid;
  @JsonKey(name: "transactionID")
  String? transactionID;
  @JsonKey(name: "userID")
  int? userID;
  @JsonKey(name: "outletNo")
  String? outletNo;
  @JsonKey(name: "outlet")
  String? outlet;
  @JsonKey(name: "account")
  String? account;
  @JsonKey(name: "oid")
  int? oid;
  @JsonKey(name: "operator")
  String? operator;
  @JsonKey(name: "lastBalance")
  double? lastBalance;
  @JsonKey(name: "requestedAmount")
  double? requestedAmount;
  @JsonKey(name: "amount")
  double? amount;
  @JsonKey(name: "balance")
  double? balance;
  @JsonKey(name: "slabCommType")
  String? slabCommType;
  @JsonKey(name: "commission")
  double? commission;
  @JsonKey(name: "entryDate")
  String? entryDate;
  @JsonKey(name: "api")
  String? api;
  @JsonKey(name: "liveID")
  String? liveID;
  @JsonKey(name: "vendorID")
  String? vendorID;
  @JsonKey(name: "apiRequestID")
  String? apiRequestID;
  @JsonKey(name: "modifyDate")
  String? modifyDate;
  @JsonKey(name: "optional1")
  String? optional1;
  @JsonKey(name: "optional2")
  String? optional2;
  @JsonKey(name: "optional3")
  String? optional3;
  @JsonKey(name: "optional4")
  String? optional4;
  @JsonKey(name: "display1")
  String? display1;
  @JsonKey(name: "display2")
  String? display2;
  @JsonKey(name: "display3")
  String? display3;
  @JsonKey(name: "display4")
  String? display4;
  @JsonKey(name: "switchingName")
  String? switchingName;
  @JsonKey(name: "circleName")
  String? circleName;
  @JsonKey(name: "isWTR")
  bool? isWTR;
  @JsonKey(name: "commType")
  bool? commType;
  @JsonKey(name: "gstAmount")
  double? gstAmount;
  @JsonKey(name: "tdsAmount")
  double? tdsAmount;
  @JsonKey(name: "customerNo")
  String? customerNo;
  @JsonKey(name: "ccMobile")
  String? ccMobile;
  @JsonKey(name: "apiCode")
  String? apiCode;
  @JsonKey(name: "requestMode")
  String? requestMode;


  SendMoneyBankReport(
      {this.intType,
      this.type_,
      this.refundStatus,
      this.refundStatus_,
      this.opening,
      this.outletUserMobile,
      this.outletUserCompany,
      this.senderMobile,
      this.groupID,
      this.ccf,
      this.surcharge,
      this.refundGST,
      this.amtWithTDS,
      this.creditedAmount,
      this.ccName,
      this.ccMobileNo,
      this.serviceID,
      this.tid,
      this.transactionID,
      this.userID,
      this.outletNo,
      this.outlet,
      this.account,
      this.oid,
      this.operator,
      this.lastBalance,
      this.requestedAmount,
      this.amount,
      this.balance,
      this.slabCommType,
      this.commission,
      this.entryDate,
      this.api,
      this.liveID,
      this.vendorID,
      this.apiRequestID,
      this.modifyDate,
      this.optional1,
      this.optional2,
      this.optional3,
      this.optional4,
      this.display1,
      this.display2,
      this.display3,
      this.display4,
      this.switchingName,
      this.circleName,
      this.isWTR,
      this.commType,
      this.gstAmount,
      this.tdsAmount,
      this.customerNo,
      this.ccMobile,
      this.apiCode,
      this.requestMode});

  factory SendMoneyBankReport.fromJson(Map<String, dynamic> json) =>
      _$SendMoneyBankReportFromJson(json);

  Map<String, dynamic> toJson() => _$SendMoneyBankReportToJson(this);
}
