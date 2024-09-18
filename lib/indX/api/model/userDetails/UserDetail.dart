import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import '../signup/ChildRoles.dart';
import 'UserDetailRank.dart';

part 'UserDetail.g.dart';

@JsonSerializable()
class UserDetail  {
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
  @JsonKey(name: "ekycid")
  int? ekycid;
  @JsonKey(name: "stateID")
  int? stateID;
  @JsonKey(name: "kycStatus")
  int? kycStatus;
  @JsonKey(name: "loginID")
  int? loginID;
  @JsonKey(name: "lt")
  int? lt;
  @JsonKey(name: "city")
  String? city;
  @JsonKey(name: "stateName")
  String? stateName;
  @JsonKey(name: "roles")
  List<ChildRoles>? roles;
  @JsonKey(name: "slabs")
  String? slabs;
  @JsonKey(name: "states")
  String? states;
  @JsonKey(name: "ip")
  String? ip;
  @JsonKey(name: "browser")
  String? browser;
  @JsonKey(name: "resultCode")
  int? resultCode;
  @JsonKey(name: "msg")
  String? msg;
  @JsonKey(name: "roleID")
  int? roleID;
  @JsonKey(name: "role")
  String? role;
  @JsonKey(name: "referalID")
  int? referalID;
  @JsonKey(name: "slabID")
  int? slabID;
  @JsonKey(name: "isVirtual")
  bool? isVirtual;
  @JsonKey(name: "isWebsite")
  bool? isWebsite;
  @JsonKey(name: "isAdminDefined")
  bool? isAdminDefined;
  @JsonKey(name: "isSurchargeGST")
  bool? isSurchargeGST;
  @JsonKey(name: "prefix")
  String? prefix;
  @JsonKey(name: "outletID")
  int? outletID;
  @JsonKey(name: "wid")
  int? wid;
  @JsonKey(name: "isDoubleFactor")
  bool? isDoubleFactor;
  @JsonKey(name: "regDate")
  String? regDate;
  @JsonKey(name: "activationDate")
  String? activationDate;
  @JsonKey(name: "isRealAPI")
  bool? isRealAPI;
  @JsonKey(name: "isTopup")
  int? isTopup;
  @JsonKey(name: "rank")
  UserDetailRank? rank;
  @JsonKey(name: "isMobileVerified")
  bool? isMobileVerified;
  @JsonKey(name: "isEmailVerified")
  bool? isEmailVerified;
  @JsonKey(name: "isRenewalRequired")
  bool? isRenewalRequired;
  @JsonKey(name: "isGoogle2FAEnable")
  bool? isGoogle2FAEnable;
  @JsonKey(name: "isGoogle2FARegister")
  bool? isGoogle2FARegister;
  @JsonKey(name: "toupAmount")
  double? toupAmount;


  UserDetail(
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
      this.accountName,
      this.ekycid,
      this.stateID,
      this.kycStatus,
      this.loginID,
      this.lt,
      this.city,
      this.stateName,
      this.roles,
      this.slabs,
      this.states,
      this.ip,
      this.browser,
      this.resultCode,
      this.msg,
      this.roleID,
      this.role,
      this.referalID,
      this.slabID,
      this.isVirtual,
      this.isWebsite,
      this.isAdminDefined,
      this.isSurchargeGST,
      this.prefix,
      this.outletID,
      this.wid,
      this.isDoubleFactor,
      this.regDate,
      this.activationDate,
      this.isRealAPI,
      this.isTopup,
      this.rank,
      this.isMobileVerified,
      this.isEmailVerified,
      this.isRenewalRequired,
      this.isGoogle2FAEnable,
      this.isGoogle2FARegister,
      this.toupAmount});

  factory UserDetail.fromJson(Map<String, dynamic> json) =>
      _$UserDetailFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailToJson(this);
}
