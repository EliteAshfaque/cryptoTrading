import 'package:json_annotation/json_annotation.dart';



import 'EditUser.dart';
part 'UpdateUserRequest.g.dart';
@JsonSerializable()
class UpdateUserRequest {

  @JsonKey(name: "editUser")
  EditUser? editUser;
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

  UpdateUserRequest(this.editUser,this.loginTypeID, this.userID, this.session, this.sessionID,
    this.appid, this.imei, this.regKey, this.version, this.serialNo);

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserRequestToJson(this);
}
