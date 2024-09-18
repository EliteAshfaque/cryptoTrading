import 'package:json_annotation/json_annotation.dart';

part 'CompanyProfileData.g.dart';

@JsonSerializable()
class CompanyProfileData {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "emailId")
  String? emailId;
  @JsonKey(name: "phoneNo")
  String? phoneNo;
  @JsonKey(name: "mobileNo")
  String? mobileNo;
  @JsonKey(name: "mobileNo2")
  String? mobileNo2;
  @JsonKey(name: "accountMobileNo")
  String? accountMobileNo;
  @JsonKey(name: "accountEmailId")
  String? accountEmailId;
  @JsonKey(name: "accountPhoneNos")
  String? accountPhoneNos;
  @JsonKey(name: "accountWhatsAppNos")
  String? accountWhatsAppNos;
  @JsonKey(name: "facebook")
  String? facebook;
  @JsonKey(name: "instagram")
  String? instagram;
  @JsonKey(name: "twitter")
  String? twitter;
  @JsonKey(name: "telegram")
  String? telegram;
  @JsonKey(name: "telegramBannerUrl")
  String? telegramBannerUrl;
  @JsonKey(name: "whatsApp")
  String? whatsApp;
  @JsonKey(name: "website")
  String? website;
  @JsonKey(name: "headerTitle")
  String? headerTitle;
  @JsonKey(name: "customerCareMobileNos")
  String? customerCareMobileNos;
  @JsonKey(name: "customerCareEmailIds")
  String? customerCareEmailIds;
  @JsonKey(name: "customerPhoneNos")
  String? customerPhoneNos;
  @JsonKey(name: "customerWhatsAppNos")
  String? customerWhatsAppNos;
  @JsonKey(name: "salesPersonNo")
  String? salesPersonNo;
  @JsonKey(name: "salesPersonEmail")
  String? salesPersonEmail;
  @JsonKey(name: "appName")
  String? appName;
  @JsonKey(name: "ownerName")
  String? ownerName;
  @JsonKey(name: "ownerDesignation")
  String? ownerDesignation;
  @JsonKey(name: "kycStatus")
  int? kycStatus;
  @JsonKey(name: "signupReferalID")
  int? signupReferalID;
  @JsonKey(name: "pan")
  String? pan;
  @JsonKey(name: "userAddress")
  String? userAddress;
  @JsonKey(name: "isOutletRequired")
  bool? isOutletRequired;


  CompanyProfileData(
      {this.name,
      this.address,
      this.emailId,
      this.phoneNo,
      this.mobileNo,
      this.mobileNo2,
      this.accountMobileNo,
      this.accountEmailId,
      this.accountPhoneNos,
      this.accountWhatsAppNos,
      this.facebook,
      this.instagram,
      this.twitter,
      this.telegram,
      this.telegramBannerUrl,
      this.whatsApp,
      this.website,
      this.headerTitle,
      this.customerCareMobileNos,
      this.customerCareEmailIds,
      this.customerPhoneNos,
      this.customerWhatsAppNos,
      this.salesPersonNo,
      this.salesPersonEmail,
      this.appName,
      this.ownerName,
      this.ownerDesignation,
      this.kycStatus,
      this.signupReferalID,
      this.pan,
      this.userAddress,
      this.isOutletRequired});

  factory CompanyProfileData.fromJson(Map<String, dynamic> json) =>
      _$CompanyProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyProfileDataToJson(this);
}
