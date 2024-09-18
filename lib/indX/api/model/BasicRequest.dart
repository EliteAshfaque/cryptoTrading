import 'package:json_annotation/json_annotation.dart';
part 'BasicRequest.g.dart';
@JsonSerializable()
class BasicRequest {

  @JsonKey(name: "loginTypeID")
  int? loginTypeID;
  @JsonKey(name: "userID")
  int? userID;
  @JsonKey(name: "session")
  String? session;
  @JsonKey(name: "sessionID")
  int? sessionID;
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

  BasicRequest(this.loginTypeID, this.userID, this.session, this.sessionID,
      this.appid, this.imei, this.regKey, this.version, this.serialNo, {this.isSeller=true});

  factory BasicRequest.fromJson(Map<String, dynamic> json) =>
      _$BasicRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BasicRequestToJson(this);
}
