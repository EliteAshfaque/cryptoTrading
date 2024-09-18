import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';

part 'BankData.g.dart';

@JsonSerializable()
class BankData extends BasicResponse {
  @JsonKey(name: "accountLimit")
  int? accountLimit;
  @JsonKey(name: "sprintBankID")
  int? sprintBankID;
  @JsonKey(name: "code")
  String? code;
  @JsonKey(name: "bankType")
  String? bankType;
  @JsonKey(name: "logo")
  String? logo;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "bankName")
  String? bankName;
  @JsonKey(name: "iin")
  int? iin;
  @JsonKey(name: "isIMPS")
  bool? isIMPS;
  @JsonKey(name: "isNEFT")
  bool? isNEFT;
  @JsonKey(name: "isACVerification")
  bool?isACVerification;
  @JsonKey(name: "isaepsStatus")
  bool? isaepsStatus;
  @JsonKey(name: "ifsc")
  String? ifsc;
  @JsonKey(name: "aadhpayIIN")
  int? aadhpayIIN;
  @JsonKey(name: "iscashDeposit")
  bool? iscashDeposit;
  @JsonKey(name: "isAadharpay")
  bool? isAadharpay;


  BankData(
      {this.accountLimit,
      this.sprintBankID,
      this.code,
      this.bankType,
      this.logo,
      this.id,
      this.bankName,
      this.iin,
      this.isIMPS,
      this.isNEFT,
      this.isACVerification,
      this.isaepsStatus,
      this.ifsc,
      this.aadhpayIIN,
      this.iscashDeposit,
      this.isAadharpay});

  factory BankData.fromJson(Map<String, dynamic> json) =>
      _$BankDataFromJson(json);

  Map<String, dynamic> toJson() => _$BankDataToJson(this);
}
