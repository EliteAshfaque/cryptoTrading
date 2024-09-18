import 'package:json_annotation/json_annotation.dart';
part 'OTPResendRequest.g.dart';
@JsonSerializable()
class OTPResendRequest {

  @JsonKey(name: "loginTypeID")
  int? loginTypeID;
  @JsonKey(name: "oTPSession")
  String? oTPSession;
  @JsonKey(name: "domain")
  String? domain;
  @JsonKey(name: "appid")
  String? appid;
  @JsonKey(name: "imei")
  String? imei;
  @JsonKey(name: "regKey")
  String? regKey;
  @JsonKey(name: "version")
  String? version;
  @JsonKey(name: "serialNo")
  String? serialNo;
  @JsonKey(name: "isSeller")
  bool? isSeller;


  OTPResendRequest(
      {this.loginTypeID,
      this.oTPSession,
      this.domain,
      this.appid,
      this.imei,
      this.regKey,
      this.version,
      this.serialNo,
      this.isSeller=true});

  factory OTPResendRequest.fromJson(Map<String, dynamic> json) =>
      _$OTPResendRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OTPResendRequestToJson(this);
}
