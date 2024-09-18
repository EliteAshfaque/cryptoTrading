import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'estimateDeduction.g.dart';

@JsonSerializable()
class EstimateDeductionApiStruct extends Base {

  EstimateDeductionApiStruct({required bool success}) : super(result: Result(message: EstimateDeductionStruct),
      success: success);

  factory EstimateDeductionApiStruct.fromJson(Map<String, dynamic> json) =>  _$EstimateDeductionApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$EstimateDeductionApiStructToJson(this);
}

@JsonSerializable()
class EstimateDeductionStruct {

  @JsonKey(name:"afterTds")
  String? afterTds;

  @JsonKey(name:"afterCommission")
  String? afterCommission;

  @JsonKey(name:"finalAmount")
  String? finalAmount;

  @JsonKey(name:"tdsPercent")
  String? tdsPercent;

  @JsonKey(name:"tdsToken")
  String? tdsToken;

  EstimateDeductionStruct({this.finalAmount, this.afterCommission, this.afterTds, this.tdsPercent,
    this.tdsToken});

  factory EstimateDeductionStruct.fromJson(Map<String, dynamic> json) =>  _$EstimateDeductionStructFromJson(json);
  Map<String, dynamic> toJson() => _$EstimateDeductionStructToJson(this);

}