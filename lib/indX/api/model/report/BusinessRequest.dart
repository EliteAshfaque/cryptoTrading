import 'package:json_annotation/json_annotation.dart';


part 'BusinessRequest.g.dart';

@JsonSerializable()
class BusinessRequest {

  @JsonKey(name: "FromDate")
  String? FromDate;
  @JsonKey(name: "ToDate")
  String? ToDate;
  @JsonKey(name: "Leg")
  String? Leg;
  @JsonKey(name: "LevelNo")
  String? LevelNo;
  @JsonKey(name: "BusinessType")
  int? BusinessType;
  @JsonKey(name: "SponserId")
  String? SponserId;


  BusinessRequest(
      {this.FromDate, this.ToDate, this.Leg, this.LevelNo, this.BusinessType, this.SponserId});

  factory BusinessRequest.fromJson(Map<String, dynamic> json) =>
      _$BusinessRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessRequestToJson(this);
}
