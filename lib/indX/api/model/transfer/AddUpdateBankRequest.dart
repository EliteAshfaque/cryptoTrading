import 'package:json_annotation/json_annotation.dart';

import '../BasicRequest.dart';
import '../BasicResponse.dart';

part 'AddUpdateBankRequest.g.dart';

@JsonSerializable()
class AddUpdateBankRequest extends BasicRequest {
  @JsonKey(name: "AccountOTP")
  String? AccountOTP;
  @JsonKey(name: "ReferenceID")
  int? ReferenceID;
  @JsonKey(name: "AccountHolder")
  String? AccountHolder;
  @JsonKey(name: "AccountNumber")
  String? AccountNumber;
  @JsonKey(name: "BankID")
  int? BankID;
  @JsonKey(name: "BankName")
  String? BankName;
  @JsonKey(name: "ifsc")
  String? ifsc;
  @JsonKey(name: "UTR")
  String? UTR;
  @JsonKey(name: "UpdateID")
  int? UpdateID;


  AddUpdateBankRequest(
      this.AccountOTP,
      this.ReferenceID,
      this.AccountHolder,
      this.AccountNumber,
      this.BankID,
      this.BankName,
      this.ifsc,
      this.UTR,
      this.UpdateID, super.loginTypeID, super.userID, super.session, super.sessionID, super.appid, super.imei, super.regKey, super.version, super.serialNo);

  factory AddUpdateBankRequest.fromJson(Map<String, dynamic> json) =>
      _$AddUpdateBankRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddUpdateBankRequestToJson(this);
}
