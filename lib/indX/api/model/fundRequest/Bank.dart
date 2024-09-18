import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'PaymentMode.dart';

part 'Bank.g.dart';

@JsonSerializable()
class Bank  {
  @JsonKey(name: "bankName")
  String? bankName;
  @JsonKey(name: "logo")
  String? logo;
  @JsonKey(name: "bankQRLogo")
  String? bankQRLogo;
  @JsonKey(name: "cid")
  String? cid;
  @JsonKey(name: "entryBy")
  int? entryBy;
  @JsonKey(name: "lt")
  int? lt;
  @JsonKey(name: "bankMasters")
  String? bankMasters;
  @JsonKey(name: "qrPath")
  String? qrPath;
  @JsonKey(name: "preStatusofQR")
  int? preStatusofQR;
  @JsonKey(name: "mode")
  List<PaymentMode>? mode = null;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "branchName")
  String? branchName;
  @JsonKey(name: "accountHolder")
  String? accountHolder;
  @JsonKey(name: "accountNo")
  String? accountNo;
  @JsonKey(name: "isqrenable")
  bool? isqrenable;
  @JsonKey(name: "neftStatus")
  bool? neftStatus;
  @JsonKey(name: "neftID")
  int? neftID;
  @JsonKey(name: "rtgsStatus")
  bool? rtgsStatus;
  @JsonKey(name: "rtgsid")
  int? rtgsid;
  @JsonKey(name: "impsStatus")
  bool? impsStatus;
  @JsonKey(name: "impsid")
  int? impsid;
  @JsonKey(name: "thirdPartyTransferStatus")
  bool? thirdPartyTransferStatus;
  @JsonKey(name: "thirdPartyTransferID")
  int? thirdPartyTransferID;
  @JsonKey(name: "cashDepositStatus")
  bool? cashDepositStatus;
  @JsonKey(name: "cashDepositID")
  int? cashDepositID;
  @JsonKey(name: "gccStatus")
  bool? gccStatus;
  @JsonKey(name: "gccid")
  int? gccid;
  @JsonKey(name: "chequeStatus")
  bool? chequeStatus;
  @JsonKey(name: "chequeID")
  int? chequeID;
  @JsonKey(name: "scanPayStatus")
  bool? scanPayStatus;
  @JsonKey(name: "scanPayID")
  int? scanPayID;
  @JsonKey(name: "upiStatus")
  bool? upiStatus;
  @JsonKey(name: "upiid")
  int? upiid;
  @JsonKey(name: "exchangeStatus")
  bool? exchangeStatus;
  @JsonKey(name: "exchangeID")
  int? exchangeID;
  @JsonKey(name: "ifscCode")
  String? ifscCode;
  @JsonKey(name: "charge")
  double? charge;
  @JsonKey(name: "rImageUrl")
  String? rImageUrl;
  @JsonKey(name: "isbankLogoAvailable")
  bool? isbankLogoAvailable;
  @JsonKey(name: "upinUmber")
  String? upinumber;


  Bank(
      {this.bankName,
      this.logo,
      this.bankQRLogo,
      this.cid,
      this.entryBy,
      this.lt,
      this.bankMasters,
      this.qrPath,
      this.preStatusofQR,
      this.mode,
      this.id,
      this.branchName,
      this.accountHolder,
      this.accountNo,
      this.isqrenable,
      this.neftStatus,
      this.neftID,
      this.rtgsStatus,
      this.rtgsid,
      this.impsStatus,
      this.impsid,
      this.thirdPartyTransferStatus,
      this.thirdPartyTransferID,
      this.cashDepositStatus,
      this.cashDepositID,
      this.gccStatus,
      this.gccid,
      this.chequeStatus,
      this.chequeID,
      this.scanPayStatus,
      this.scanPayID,
      this.upiStatus,
      this.upiid,
      this.exchangeStatus,
      this.exchangeID,
      this.ifscCode,
      this.charge,
      this.rImageUrl,
      this.isbankLogoAvailable,
      this.upinumber});

  factory Bank.fromJson(Map<String, dynamic> json) =>
      _$BankFromJson(json);

  Map<String, dynamic> toJson() => _$BankToJson(this);
}
