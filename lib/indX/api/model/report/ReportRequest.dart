import 'package:json_annotation/json_annotation.dart';
import '../BasicRequest.dart';

part 'ReportRequest.g.dart';

@JsonSerializable()
class ReportRequest extends BasicRequest {

  @JsonKey(name: "WalletTypeID")
  int? WalletTypeID;
  @JsonKey(name: "isExport")
  bool? isExport;
  @JsonKey(name: "isSelf")
  bool? isSelf;
  @JsonKey(name: "topRows")
  String? topRows;
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "oid")
  int? oid;
  @JsonKey(name: "fromDate")
  String? fromDate;
  @JsonKey(name: "toDate")
  String? toDate;
  @JsonKey(name: "transactionID")
  String? transactionID;
  @JsonKey(name: "accountNo")
  String? accountNo;
  @JsonKey(name: "tMode")
  int? tMode;
  @JsonKey(name: "uMobile")
  String? uMobile;


  ReportRequest(
      this.WalletTypeID,
      this.isExport,
      this.isSelf,
      this.topRows,
      this.status,
      this.oid,
      this.fromDate,
      this.toDate,
      this.transactionID,
      this.accountNo,
      this.tMode,
      this.uMobile,super.loginTypeID, super.userID, super.session, super.sessionID, super.appid, super.imei, super.regKey, super.version, super.serialNo);

  factory ReportRequest.fromJson(Map<String, dynamic> json) =>
      _$ReportRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReportRequestToJson(this);
}
