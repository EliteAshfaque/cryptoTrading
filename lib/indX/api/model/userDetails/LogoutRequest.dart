import 'package:json_annotation/json_annotation.dart';

import '../BasicRequest.dart';

part 'LogoutRequest.g.dart';

@JsonSerializable()
class LogoutRequest extends BasicRequest {

  @JsonKey(name: "sessType")
  String? sessType;


  LogoutRequest(
      this.sessType,super.loginTypeID, super.userID, super.session, super.sessionID, super.appid, super.imei, super.regKey, super.version, super.serialNo);

  factory LogoutRequest.fromJson(Map<String, dynamic> json) =>
      _$LogoutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LogoutRequestToJson(this);
}
