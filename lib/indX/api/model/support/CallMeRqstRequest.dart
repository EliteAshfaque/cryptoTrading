import 'package:json_annotation/json_annotation.dart';
import '../BasicRequest.dart';

import '../BasicResponse.dart';

part 'CallMeRqstRequest.g.dart';

@JsonSerializable()
class CallMeRqstRequest extends BasicRequest{

  @JsonKey(name: "mobileNo")
  String? mobileNo;


  CallMeRqstRequest(this.mobileNo, super.loginTypeID, super.userID, super.session, super.sessionID, super.appid, super.imei, super.regKey, super.version, super.serialNo);

  factory CallMeRqstRequest.fromJson(Map<String, dynamic> json) =>
      _$CallMeRqstRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CallMeRqstRequestToJson(this);
}
