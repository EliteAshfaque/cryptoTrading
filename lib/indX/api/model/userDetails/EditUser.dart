import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';

part 'EditUser.g.dart';

@JsonSerializable()
class EditUser {
  @JsonKey(name: "profilePic")
  String? profilePic;
  @JsonKey(name: "branchName")
  String? branchName;
  @JsonKey(name: "commRate")
  double? commRate;
  @JsonKey(name: "aadhar")
  String? aadhar;
  @JsonKey(name: "pan")
  String? pan;
  @JsonKey(name: "gstin")
  String? gstin;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "userID")
  int? userID;
  @JsonKey(name: "mobileNo")
  String? mobileNo;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "outletName")
  String? outletName;
  @JsonKey(name: "emailID")
  String? emailID;
  @JsonKey(name: "isGSTApplicable")
  bool? isGSTApplicable;
  @JsonKey(name: "isTDSApplicable")
  bool? isTDSApplicable;
  @JsonKey(name: "isCCFGstApplicable")
  bool? isCCFGstApplicable;
  @JsonKey(name: "pincode")
  String? pincode;
  @JsonKey(name: "dob")
  String? dob;
  @JsonKey(name: "shopType")
  String? shopType;
  @JsonKey(name: "qualification")
  String? qualification;
  @JsonKey(name: "poupulation")
  String? poupulation;
  @JsonKey(name: "locationType")
  String? locationType;
  @JsonKey(name: "landmark")
  String? landmark;
  @JsonKey(name: "alternateMobile")
  String? alternateMobile;
  @JsonKey(name: "bankName")
  String? bankName;
  @JsonKey(name: "ifsc")
  String? ifsc;
  @JsonKey(name: "accountNumber")
  String? accountNumber;
  @JsonKey(name: "accountName")
  String? accountName;


  EditUser(
      {this.profilePic,
      this.branchName,
      this.commRate,
      this.aadhar,
      this.pan,
      this.gstin,
      this.address,
      this.userID,
      this.mobileNo,
      this.name,
      this.outletName,
      this.emailID,
      this.isGSTApplicable,
      this.isTDSApplicable,
      this.isCCFGstApplicable,
      this.pincode,
      this.dob,
      this.shopType,
      this.qualification,
      this.poupulation,
      this.locationType,
      this.landmark,
      this.alternateMobile,
      this.bankName,
      this.ifsc,
      this.accountNumber,
      this.accountName});

  factory EditUser.fromJson(Map<String, dynamic> json) =>
      _$EditUserFromJson(json);

  Map<String, dynamic> toJson() => _$EditUserToJson(this);
}
