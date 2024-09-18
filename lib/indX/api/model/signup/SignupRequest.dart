import 'package:json_annotation/json_annotation.dart';

import 'UserCreateSignup.dart';
part 'SignupRequest.g.dart';
@JsonSerializable()
class SignupRequest {

  @JsonKey(name: "referalID")
  String? referalID;
  @JsonKey(name: "referalIDstr")
  String? referalIDstr;
  @JsonKey(name: "legs")
  String? legs;
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
  @JsonKey(name: "userCreate")
  UserCreateSignup? userCreate;


  SignupRequest(
      {this.referalID,
      this.referalIDstr,
      this.legs,
      this.domain,
      this.appid,
      this.imei,
      this.regKey,
      this.version,
      this.serialNo,
      this.isSeller=true,
      this.userCreate});

  factory SignupRequest.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);
}
