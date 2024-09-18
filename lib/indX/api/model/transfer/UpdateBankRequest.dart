
import 'package:json_annotation/json_annotation.dart';

import '../BasicRequest.dart';



part 'UpdateBankRequest.g.dart';

@JsonSerializable()
class UpdateBankRequest extends BasicRequest{

  @JsonKey(name: "UpdateID")
  int? UpdateID;

  UpdateBankRequest(
      this.UpdateID,super.loginTypeID, super.userID, super.session, super.sessionID, super.appid, super.imei, super.regKey, super.version, super.serialNo);

  factory UpdateBankRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateBankRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateBankRequestToJson(this);
}
