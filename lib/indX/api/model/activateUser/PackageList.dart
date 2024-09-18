import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';

part 'PackageList.g.dart';

@JsonSerializable()
class PackageList {
  @JsonKey(name: "packageId")
  int? packageId;
  @JsonKey(name: "packageName")
  String? packageName;
  @JsonKey(name: "packageCost")
  double? packageCost;
  @JsonKey(name: "isTopup")
  int? isTopup;
  @JsonKey(name: "rangePackageCost")
  double? rangePackageCost;
  @JsonKey(name: "isRangePackageCost")
  bool? isRangePackageCost;
  @JsonKey(name: "dailyROI")
  String? dailyROI;
  @JsonKey(name: "isRoi")
  bool? isRoi;
  @JsonKey(name: "noOfDays")
  int? noOfDays;
  @JsonKey(name: "remark")
  String? remark;
  @JsonKey(name: "monthlyMint")
  double? monthlyMint;
  @JsonKey(name: "lockingPeriod")
  int? lockingPeriod;
  @JsonKey(name: "packageCurrencyId")
  int? packageCurrencyId;
  @JsonKey(name: "packageCurrency")
  String? packageCurrency;
  @JsonKey(name: "defaultCurrency")
  String? defaultCurrency;
  @JsonKey(name: "defaultCurrencyId")
  int? defaultCurrencyId;


  PackageList(
      {this.packageId,
      this.packageName,
      this.packageCost,
      this.isTopup,
      this.rangePackageCost,
      this.isRangePackageCost,
      this.dailyROI,
      this.isRoi,
      this.noOfDays,
      this.remark,
      this.monthlyMint,
      this.lockingPeriod,
      this.packageCurrencyId,
      this.packageCurrency,
      this.defaultCurrency,
      this.defaultCurrencyId});

  factory PackageList.fromJson(Map<String, dynamic> json) =>
      _$PackageListFromJson(json);

  Map<String, dynamic> toJson() => _$PackageListToJson(this);
}
