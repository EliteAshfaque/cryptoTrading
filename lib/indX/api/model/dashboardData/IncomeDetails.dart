import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';

part 'IncomeDetails.g.dart';

@JsonSerializable()
class IncomeDetails  {
  @JsonKey(name: "incomeOPID")
  int? incomeOPID;
  @JsonKey(name: "incomeFigure")
  double? incomeFigure;
  @JsonKey(name: "incomeAfterTax")
  double? incomeAfterTax;
  @JsonKey(name: "incomeName")
  String? incomeName;
  @JsonKey(name: "incomeCategoryID")
  int? incomeCategoryID;
  @JsonKey(name: "incomeCategoryName")
  String? incomeCategoryName;


  IncomeDetails(
      {this.incomeOPID,
      this.incomeFigure,
      this.incomeAfterTax,
      this.incomeName,
      this.incomeCategoryID,
      this.incomeCategoryName});

  factory IncomeDetails.fromJson(Map<String, dynamic> json) =>
      _$IncomeDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$IncomeDetailsToJson(this);
}
