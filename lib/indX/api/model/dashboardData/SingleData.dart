import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';

part 'SingleData.g.dart';

@JsonSerializable()
class SingleData {
  @JsonKey(name: "directDownlinelUser")
  int? directDownlinelUser;
  @JsonKey(name: "directDownlinelUserActive")
  int? directDownlinelUserActive;
  @JsonKey(name: "directDownlinelUserDeactive")
  int? directDownlinelUserDeactive;
  @JsonKey(name: "allDownlinelUser")
  int? allDownlinelUser;
  @JsonKey(name: "allDownlinelUserActive")
  int? allDownlinelUserActive;
  @JsonKey(name: "allDownlinelUserDeActive")
  int? allDownlinelUserDeActive;
  @JsonKey(name: "packageName")
  String? packageName;
  @JsonKey(name: "packageAmount")
  double? packageAmount;
  @JsonKey(name: "totalSponser")
  int? totalSponser;
  @JsonKey(name: "totalSponserActive")
  int? totalSponserActive;
  @JsonKey(name: "totalSponserDeactive")
  int? totalSponserDeactive;
  @JsonKey(name: "totalTeam")
  int? totalTeam;
  @JsonKey(name: "totalActive")
  int? totalActive;
  @JsonKey(name: "totalDeactive")
  int? totalDeactive;
  @JsonKey(name: "totalLeftTeam")
  int? totalLeftTeam;
  @JsonKey(name: "totalLeftActive")
  int? totalLeftActive;
  @JsonKey(name: "totalLeftDeactive")
  int? totalLeftDeactive;
  @JsonKey(name: "totalRightTeam")
  int? totalRightTeam;
  @JsonKey(name: "totalRightActive")
  int? totalRightActive;
  @JsonKey(name: "totalRightDeactive")
  int? totalRightDeactive;
  @JsonKey(name: "leftBusiness")
  double? leftBusiness;
  @JsonKey(name: "rightBusiness")
  double? rightBusiness;
  @JsonKey(name: "totalBusiness")
  double? totalBusiness;
  @JsonKey(name: "directBusiness")
  double? directBusiness;
  @JsonKey(name: "sponserBusiness")
  double? sponserBusiness;
  @JsonKey(name: "leftReferralLink")
  String? leftReferralLink;
  @JsonKey(name: "rightReferralLink")
  String? rightReferralLink;
  @JsonKey(name: "singleLink")
  String? singleLink;
  @JsonKey(name: "selfBusiness")
  double? selfBusiness;
  @JsonKey(name: "selfBV")
  double? selfBV;
  @JsonKey(name: "selfPV")
  double? selfPV;


  SingleData(
      {this.directDownlinelUser,
      this.directDownlinelUserActive,
      this.directDownlinelUserDeactive,
      this.allDownlinelUser,
      this.allDownlinelUserActive,
      this.allDownlinelUserDeActive,
      this.packageName,
      this.packageAmount,
      this.totalSponser,
      this.totalSponserActive,
      this.totalSponserDeactive,
      this.totalTeam,
      this.totalActive,
      this.totalDeactive,
      this.totalLeftTeam,
      this.totalLeftActive,
      this.totalLeftDeactive,
      this.totalRightTeam,
      this.totalRightActive,
      this.totalRightDeactive,
      this.leftBusiness,
      this.rightBusiness,
      this.totalBusiness,
      this.directBusiness,
      this.sponserBusiness,
      this.leftReferralLink,
      this.rightReferralLink,
      this.singleLink,
      this.selfBusiness,
      this.selfBV,
      this.selfPV});

  factory SingleData.fromJson(Map<String, dynamic> json) =>
      _$SingleDataFromJson(json);

  Map<String, dynamic> toJson() => _$SingleDataToJson(this);
}
