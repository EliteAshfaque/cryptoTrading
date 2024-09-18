import 'package:json_annotation/json_annotation.dart';
part 'ReportData.g.dart';
@JsonSerializable()
class ReportData {

  @JsonKey(name: "oid")
  int? oid;
  @JsonKey(name: "levelNo")
  int? levelNo;
  @JsonKey(name: "referalID")
  int? referalID;
  @JsonKey(name: "packageAmount")
  double? packageAmount;
  @JsonKey(name: "amount")
  double? amount;
  @JsonKey(name: "packageCost")
  double? packageCost;
  @JsonKey(name: "selfBussiness")
  double? selfBussiness;
  @JsonKey(name: "teamBussiness")
  double? teamBussiness;
  @JsonKey(name: "directBusiness")
  double? directBusiness;
  @JsonKey(name: "introducedBy")
  int? introducedBy;
  @JsonKey(name: "businessTypeId")
  String? businessTypeId;
  @JsonKey(name: "businessType")
  String? businessType;
  @JsonKey(name: "businessDate")
  String? businessDate;
  @JsonKey(name: "businessCurrency")
  String? businessCurrency;
  @JsonKey(name: "entryDate")
  String? entryDate;
  @JsonKey(name: "activationDate")
  String? activationDate;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "regDate")
  String? regDate;
  @JsonKey(name: "registerDate")
  String? registerDate;
  @JsonKey(name: "mobileNo")
  String? mobileNo;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "userName")
  String? userName;
  @JsonKey(name: "username")
  String? username;
  @JsonKey(name: "emailID")
  String? emailID;
  @JsonKey(name: "strUserId")
  String? strUserId;
  @JsonKey(name: "userID")
  int? userID;
  @JsonKey(name: "userId")
  int? userId;
  @JsonKey(name: "parentId")
  int? parentId;
  @JsonKey(name: "parentName")
  String? parentName;
  @JsonKey(name: "sponserId")
  String? sponserId;
  @JsonKey(name: "sponserName")
  String? sponserName;
  @JsonKey(name: "position")
  String? position;
  @JsonKey(name: "leg")
  String? leg;
  @JsonKey(name: "legs")
  String? legs;


  ReportData(
      {this.oid,
      this.levelNo,
      this.referalID,
      this.packageAmount,
      this.amount,
      this.packageCost,
      this.selfBussiness,
      this.teamBussiness,
      this.directBusiness,
      this.introducedBy,
      this.businessTypeId,
      this.businessType,
      this.businessDate,
      this.businessCurrency,
      this.entryDate,
      this.activationDate,
      this.status,
      this.regDate,
      this.registerDate,
      this.mobileNo,
      this.name,
      this.userName,
      this.username,
      this.emailID,
      this.strUserId,
      this.userID,
      this.userId,
      this.parentId,
      this.parentName,
      this.sponserId,
      this.sponserName,
      this.position,
      this.leg,
      this.legs});

  factory ReportData.fromJson(Map<String, dynamic> json) =>
      _$ReportDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReportDataToJson(this);
}
