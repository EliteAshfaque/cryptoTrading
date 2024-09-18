import 'package:json_annotation/json_annotation.dart';
part 'UserCreateSignup.g.dart';
@JsonSerializable()
class UserCreateSignup {
  @JsonKey(name: "referalID")
  String? referalID;
  @JsonKey(name: "referalIDstr")
  String? referalIDstr;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "mobileNo")
  String? mobileNo;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "outletName")
  String? outletName;
  @JsonKey(name: "roleID")
  int? roleID;
  @JsonKey(name: "pincode")
  String? pincode;
  @JsonKey(name: "legs")
  String? legs;
  @JsonKey(name: "countryCode")
  String? countryCode;
  @JsonKey(name: "emailID")
  String? emailID;
  @JsonKey(name: "isSeller")
  bool? isSeller;


  UserCreateSignup(
      {this.referalID,
      this.referalIDstr,
      this.address,
      this.mobileNo,
      this.name,
      this.outletName,
      this.roleID,
      this.pincode,
      this.legs,
      this.countryCode,
      this.emailID,
      this.isSeller=true});

  factory UserCreateSignup.fromJson(Map<String, dynamic> json) =>
      _$UserCreateSignupFromJson(json);

  Map<String, dynamic> toJson() => _$UserCreateSignupToJson(this);
}
