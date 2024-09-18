import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'IncomeDetails.dart';
import 'SingleData.dart';

part 'DashboardData.g.dart';

@JsonSerializable()
class DashboardData {

  @JsonKey(name: "packageExpireInDays")
  int? packageExpireInDays;
  @JsonKey(name: "singleData")
  SingleData? singleData;
  @JsonKey(name: "incomeDetails")
  List<IncomeDetails>? incomeDetails;


  DashboardData({this.packageExpireInDays,this.singleData, this.incomeDetails});

  factory DashboardData.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDataToJson(this);
}
