import 'package:json_annotation/json_annotation.dart';

import '../BasicRequest.dart';

part 'ChangePinPassRequest.g.dart';

@JsonSerializable()
class ChangePinPassRequest extends BasicRequest {
  @JsonKey(name: "isPin")
  bool? isPin;
  @JsonKey(name: "oldP")
  String? oldP;
  @JsonKey(name: "NewP")
  String? NewP;
  @JsonKey(name: "ConfirmP")
  String? ConfirmP;


  ChangePinPassRequest(
      this.isPin,
      this.oldP,
      this.NewP,
      this.ConfirmP,super.loginTypeID, super.userID, super.session, super.sessionID, super.appid, super.imei, super.regKey, super.version, super.serialNo);

  factory ChangePinPassRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePinPassRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePinPassRequestToJson(this);
}
