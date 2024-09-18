import 'package:json_annotation/json_annotation.dart';
part 'OTPRequest.g.dart';
@JsonSerializable()
class OTPRequest {

  @JsonKey(name: "loginTypeID")
  int? loginTypeID;
  @JsonKey(name: "otp")
  String? otp;
  @JsonKey(name: "oTPSession")
  String? oTPSession;
  @JsonKey(name: "oTPType")
  int? oTPType;
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


  OTPRequest(
      {this.loginTypeID,
      this.otp,
      this.oTPSession,
      this.oTPType,
      this.domain,
      this.appid,
      this.imei,
      this.regKey,
      this.version,
      this.serialNo,
      this.isSeller=true});

  factory OTPRequest.fromJson(Map<String, dynamic> json) =>
      _$OTPRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OTPRequestToJson(this);
}
