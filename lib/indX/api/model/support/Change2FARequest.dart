import 'package:json_annotation/json_annotation.dart';
import '../BasicRequest.dart';

import '../BasicResponse.dart';

part 'Change2FARequest.g.dart';

@JsonSerializable()
class Change2FARequest extends BasicRequest{
  @JsonKey(name: "isDoubleFactor")
  bool? isDoubleFactor;
  @JsonKey(name: "otp")
  String? otp;
  @JsonKey(name: "refID")
  String? refID;


  Change2FARequest(this.isDoubleFactor, this.otp, this.refID, super.loginTypeID, super.userID, super.session, super.sessionID, super.appid, super.imei, super.regKey, super.version, super.serialNo);

  factory Change2FARequest.fromJson(Map<String, dynamic> json) =>
      _$Change2FARequestFromJson(json);

  Map<String, dynamic> toJson() => _$Change2FARequestToJson(this);
}
