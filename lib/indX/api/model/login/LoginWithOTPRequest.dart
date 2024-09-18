import 'package:json_annotation/json_annotation.dart';
part 'LoginWithOTPRequest.g.dart';
@JsonSerializable()
class LoginWithOTPRequest {
  @JsonKey(name: "loginTypeID")
  int? loginTypeID;
  @JsonKey(name: "MobileNo")
  String? MobileNo;
  @JsonKey(name: "Otp")
  String? Otp;
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


  LoginWithOTPRequest(
      {this.loginTypeID,
      this.MobileNo,
      this.Otp,
      this.domain,
      this.appid,
      this.imei,
      this.regKey,
      this.version,
      this.serialNo,
      this.isSeller=true});

  factory LoginWithOTPRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginWithOTPRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginWithOTPRequestToJson(this);
}
