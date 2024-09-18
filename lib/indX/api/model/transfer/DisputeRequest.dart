
import 'package:json_annotation/json_annotation.dart';

import '../BasicRequest.dart';



part 'DisputeRequest.g.dart';

@JsonSerializable()
class DisputeRequest extends BasicRequest{

  @JsonKey(name: "tid")
  int? tid;
  @JsonKey(name: "transactionID")
  String? transactionID;
  @JsonKey(name: "isResend")
  bool? isResend;
  @JsonKey(name: "otp")
  String? otp;
  @JsonKey(name: "refID")
  String? refID;


  DisputeRequest(
      this.tid,
      this.transactionID,
      this.isResend,
      this.otp,
      this.refID, super.loginTypeID, super.userID, super.session, super.sessionID, super.appid, super.imei, super.regKey, super.version, super.serialNo);

  factory DisputeRequest.fromJson(Map<String, dynamic> json) =>
      _$DisputeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DisputeRequestToJson(this);
}
