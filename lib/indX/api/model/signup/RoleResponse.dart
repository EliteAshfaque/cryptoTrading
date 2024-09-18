import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'ChildRoles.dart';

part 'RoleResponse.g.dart';

@JsonSerializable()
class RoleResponse {
  @JsonKey(name: "statuscode")
  int? statuscode;
  @JsonKey(name: "msg")
  String? msg;
  @JsonKey(name: "refferalLink")
  String? refferalLink;
  @JsonKey(name: "isBinaryon")
  int? isBinaryon;
  @JsonKey(name: "isAppValid")
  bool? isAppValid;
  @JsonKey(name: "isVersionValid")
  bool? isVersionValid;
  @JsonKey(name: "isReferralEditable")
  bool? isReferralEditable;
  @JsonKey(name: "isCountryCodeRequired")
  bool? isCountryCodeRequired;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "legs")
  String? legs;
  @JsonKey(name: "userId")
  int? userId;
  @JsonKey(name: "signupRefferalId")
  int? signupRefferalId;
  @JsonKey(name: "childRoles")
  List<ChildRoles>? childRoles;


  RoleResponse(
      {this.statuscode,
      this.msg,
      this.refferalLink,
      this.isBinaryon,
      this.isAppValid,
      this.isVersionValid,
      this.isReferralEditable,
      this.isCountryCodeRequired,
      this.name,
      this.legs,
      this.userId,
      this.signupRefferalId,
      this.childRoles});

  factory RoleResponse.fromJson(Map<String, dynamic> json) =>
      _$RoleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RoleResponseToJson(this);
}
