import 'package:json_annotation/json_annotation.dart';
part 'LoginRequest.g.dart';
@JsonSerializable()
class LoginRequest {
  @JsonKey(name: "loginTypeID")
  int? loginTypeID;
  @JsonKey(name: "userID")
  String? userID;
  @JsonKey(name: "password")
  String? password;
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


  LoginRequest(
      {this.loginTypeID,
      this.userID,
      this.password,
      this.domain,
      this.appid,
      this.imei,
      this.regKey,
      this.version,
      this.serialNo,
      this.isSeller=true});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
