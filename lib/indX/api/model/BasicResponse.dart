import 'package:json_annotation/json_annotation.dart';

part 'BasicResponse.g.dart';

@JsonSerializable()
class BasicResponse {
  @JsonKey(name: "refID")
  String? refID;
  @JsonKey(name: "referenceID")
  int? referenceID;
  @JsonKey(name: "isReferral")
  bool? isReferral;
  @JsonKey(name: "isHeavyRefresh")
  bool? isHeavyRefresh;
  @JsonKey(name: "isTargetShow")
  bool? isTargetShow;
  @JsonKey(name: "isRealAPIPerTransaction")
  bool? isRealAPIPerTransaction;
  @JsonKey(name: "isAdminFlatComm")
  bool? isAdminFlatComm;
  @JsonKey(name: "activeFlatType")
  int? activeFlatType;
  @JsonKey(name: "isDenominationIncentive")
  bool? isDenominationIncentive;
  @JsonKey(name: "isAutoBilling")
  bool? isAutoBilling;
  @JsonKey(name: "withCustomLoginID")
  bool? withCustomLoginID;
  @JsonKey(name: "isVirtualAccountInternal")
  bool? isVirtualAccountInternal;
  @JsonKey(name: "isAccountStatement")
  bool? isAccountStatement;
  @JsonKey(name: "isAreaMaster")
  bool? isAreaMaster;
  @JsonKey(name: "isPlanServiceUpdated")
  bool? isPlanServiceUpdated;
  @JsonKey(name: "dashPreferenceApp")
  int? dashPreferenceApp;
  @JsonKey(name: "isFintechServiceOn")
  bool? isFintechServiceOn;
  @JsonKey(name: "isMLM")
  bool? isMLM;
  @JsonKey(name: "isECommerceAllowed")
  bool? isECommerceAllowed;
  @JsonKey(name: "statuscode")
  int? statuscode;
  @JsonKey(name: "msg")
  String? msg;
  @JsonKey(name: "isVersionValid")
  bool? isVersionValid;
  @JsonKey(name: "isAppValid")
  bool? isAppValid;
  @JsonKey(name: "checkID")
  int? checkID;
  @JsonKey(name: "isPasswordExpired")
  bool? isPasswordExpired;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "mobileNo")
  String? mobileNo;
  @JsonKey(name: "emailID")
  String? emailID;
  @JsonKey(name: "otpSession")
  String? otpSession;
  @JsonKey(name: "isLookUpFromAPI")
  bool? isLookUpFromAPI;
  @JsonKey(name: "isDTHInfoCall")
  bool? isDTHInfoCall;
  @JsonKey(name: "isShowPDFPlan")
  bool? isShowPDFPlan;
  @JsonKey(name: "isOTPRequired")
  bool? isOTPRequired;
  @JsonKey(name: "isResendAvailable")
  bool? isResendAvailable;
  @JsonKey(name: "isDTHInfo")
  bool? isDTHInfo;
  @JsonKey(name: "isRoffer")
  bool? isRoffer;
  @JsonKey(name: "isGreen")
  bool? isGreen;
  @JsonKey(name: "isBulkQRGeneration")
  bool? isBulkQRGeneration;
  @JsonKey(name: "isCoin")
  bool? isCoin;
  @JsonKey(name: "legs")
  String? legs;
  @JsonKey(name: "userId")
  dynamic? userId;
  @JsonKey(name: "loginUrl")
  String? loginUrl;
  @JsonKey(name: "userName")
  String? userName;
  @JsonKey(name: "password")
  String? password;
  @JsonKey(name: "isSattlemntAccountVerify")
  bool? isSattlemntAccountVerify;
  @JsonKey(name: "fiatCurrID")
  int? fiatCurrID;
  @JsonKey(name: "fiatCurrSymbol")
  String? fiatCurrSymbol;
  @JsonKey(name: "fiatCurrName")
  String? fiatCurrName;
  @JsonKey(name: "fiatTechnologyId")
  int? fiatTechnologyId;
  @JsonKey(name: "fiatImageUrl")
  String? fiatImageUrl;

  BasicResponse(
      {this.refID,
        this.referenceID,
        this.isReferral,
      this.isHeavyRefresh,
      this.isTargetShow,
      this.isRealAPIPerTransaction,
      this.isAdminFlatComm,
      this.activeFlatType,
      this.isDenominationIncentive,
      this.isAutoBilling,
      this.withCustomLoginID,
      this.isVirtualAccountInternal,
      this.isAccountStatement,
      this.isAreaMaster,
      this.isPlanServiceUpdated,
      this.dashPreferenceApp,
      this.isFintechServiceOn,
      this.isMLM,
      this.isECommerceAllowed,
      this.statuscode,
      this.msg,
      this.isVersionValid,
      this.isAppValid,
      this.checkID,
      this.isPasswordExpired,
      this.name,
      this.mobileNo,
      this.emailID,
      this.otpSession,
      this.isLookUpFromAPI,
      this.isDTHInfoCall,
      this.isShowPDFPlan,
      this.isOTPRequired,
      this.isResendAvailable,
      this.isDTHInfo,
      this.isRoffer,
      this.isGreen,
      this.isBulkQRGeneration,
      this.isCoin,
      this.legs,
      this.userId,
      this.loginUrl,
      this.userName,
      this.password,
      this.isSattlemntAccountVerify,
      this.fiatCurrID,
      this.fiatCurrSymbol,
      this.fiatCurrName,
      this.fiatTechnologyId,
      this.fiatImageUrl});

  factory BasicResponse.fromJson(Map<String, dynamic> json) =>
      _$BasicResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BasicResponseToJson(this);
}
