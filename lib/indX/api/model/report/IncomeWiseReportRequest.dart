import 'package:json_annotation/json_annotation.dart';

import '../BasicRequest.dart';

part 'IncomeWiseReportRequest.g.dart';

@JsonSerializable()
class IncomeWiseReportRequest extends BasicRequest {

  @JsonKey(name: "incomeCategoryID")
  int? incomeCategoryID;
  @JsonKey(name: "OPID")
  int? OPID;
  @JsonKey(name: "FromDate")
  String? FromDate;
  @JsonKey(name: "ToDate")
  String? ToDate;
  @JsonKey(name: "LevelNo")
  String? LevelNo;


  IncomeWiseReportRequest(
      this.incomeCategoryID,
      this.OPID,
      this.FromDate,
      this.ToDate,
      this.LevelNo,super.loginTypeID, super.userID, super.session, super.sessionID, super.appid, super.imei, super.regKey, super.version, super.serialNo);

  factory IncomeWiseReportRequest.fromJson(Map<String, dynamic> json) =>
      _$IncomeWiseReportRequestFromJson(json);

  Map<String, dynamic> toJson() => _$IncomeWiseReportRequestToJson(this);
}
