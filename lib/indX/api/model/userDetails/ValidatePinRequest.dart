import 'package:json_annotation/json_annotation.dart';

import '../BasicRequest.dart';

part 'ValidatePinRequest.g.dart';

@JsonSerializable()
class ValidatePinRequest extends BasicRequest {

  @JsonKey(name: "pin")
  String? pin;


  ValidatePinRequest(
      this.pin,super.loginTypeID, super.userID, super.session, super.sessionID, super.appid, super.imei, super.regKey, super.version, super.serialNo);

  factory ValidatePinRequest.fromJson(Map<String, dynamic> json) =>
      _$ValidatePinRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ValidatePinRequestToJson(this);
}
