import 'package:json_annotation/json_annotation.dart';

part 'LoginData.g.dart';

@JsonSerializable()
class LoginData {
  @JsonKey(name: "userID")
  int? userID;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "mobileNo")
  String? mobileNo;
  @JsonKey(name: "sessionID")
  int? sessionID;
  @JsonKey(name: "roleName")
  String? roleName;
  @JsonKey(name: "roleID")
  int? roleID;
  @JsonKey(name: "slabID")
  int? slabID;
  @JsonKey(name: "loginTypeID")
  int? loginTypeID;
  @JsonKey(name: "emailID")
  String? emailID;
  @JsonKey(name: "session")
  String? session;
  @JsonKey(name: "outletID")
  int? outletID;
  @JsonKey(name: "isDoubleFactor")
  bool? isDoubleFactor;
  @JsonKey(name: "isPinRequired")
  bool? isPinRequired;
  @JsonKey(name: "isRealAPI")
  bool? isRealAPI;
  @JsonKey(name: "isDebitAllowed")
  bool? isDebitAllowed;
  @JsonKey(name: "stateID")
  int? stateID;
  @JsonKey(name: "state")
  String? state;
  @JsonKey(name: "pincode")
  String? pincode;
  @JsonKey(name: "wid")
  int? wid;
  @JsonKey(name: "accountSecretKey")
  String? accountSecretKey;
  @JsonKey(name: "isEmailVerified")
  bool? isEmailVerified;
  @JsonKey(name: "prefix")
  String? prefix;


  LoginData(
      {this.userID,
      this.name,
      this.mobileNo,
      this.sessionID,
      this.roleName,
      this.roleID,
      this.slabID,
      this.loginTypeID,
      this.emailID,
      this.session,
      this.outletID,
      this.isDoubleFactor,
      this.isPinRequired,
      this.isRealAPI,
      this.isDebitAllowed,
      this.stateID,
      this.state,
      this.pincode,
      this.wid,
      this.accountSecretKey,
      this.isEmailVerified,
      this.prefix});

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}
