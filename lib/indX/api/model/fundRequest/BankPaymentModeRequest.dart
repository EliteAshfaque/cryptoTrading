
import 'package:json_annotation/json_annotation.dart';

import '../BasicRequest.dart';
part 'BankPaymentModeRequest.g.dart';
@JsonSerializable()
class BankPaymentModeRequest extends BasicRequest{

  @JsonKey(name: "parentid")
  int? parentid;


  BankPaymentModeRequest(this.parentid,super.loginTypeID,  super.userID, super.session, super.sessionID, super.appid, super.imei, super.regKey, super.version, super.serialNo);

  factory BankPaymentModeRequest.fromJson(Map<String, dynamic> json) =>
      _$BankPaymentModeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BankPaymentModeRequestToJson(this);
}
