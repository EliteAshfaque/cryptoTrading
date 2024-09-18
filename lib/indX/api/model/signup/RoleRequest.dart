import 'package:json_annotation/json_annotation.dart';
part 'RoleRequest.g.dart';
@JsonSerializable()
class RoleRequest {
  @JsonKey(name: "referralID")
  String? referralID;
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


  RoleRequest(
      {this.referralID,
      this.domain,
      this.appid,
      this.imei,
      this.regKey,
      this.version,
      this.serialNo,
      this.isSeller=true});

  factory RoleRequest.fromJson(Map<String, dynamic> json) =>
      _$RoleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RoleRequestToJson(this);
}
