import 'package:json_annotation/json_annotation.dart';

import '../BasicRequest.dart';
import '../BasicResponse.dart';

part 'SendMoneyBankReportRequest.g.dart';

@JsonSerializable()
class SendMoneyBankReportRequest extends BasicRequest {
  @JsonKey(name: "topRows")
  String? topRows;
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "apiid")
  String? apiid;
  @JsonKey(name: "fromDate")
  String? fromDate;
  @JsonKey(name: "toDate")
  String? toDate;
  @JsonKey(name: "childMobile")
  String? childMobile;
  @JsonKey(name: "transactionID")
  String? transactionID;
  @JsonKey(name: "accountNo")
  String? accountNo;
  @JsonKey(name: "isExport")
  bool isExport;
  @JsonKey(name: "IsRecent")
  bool IsRecent;

  SendMoneyBankReportRequest(
      this.topRows,
      this.status,
      this.apiid,
      this.fromDate,
      this.toDate,
      this.childMobile,
      this.transactionID,
      this.accountNo,
      this.isExport,
      this.IsRecent, super.loginTypeID, super.userID, super.session, super.sessionID, super.appid, super.imei, super.regKey, super.version, super.serialNo);

  factory SendMoneyBankReportRequest.fromJson(Map<String, dynamic> json) =>
      _$SendMoneyBankReportRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendMoneyBankReportRequestToJson(this);
}
