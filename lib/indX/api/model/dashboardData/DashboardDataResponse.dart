import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'DashboardData.dart';

part 'DashboardDataResponse.g.dart';

@JsonSerializable()
class DashboardDataResponse extends BasicResponse {
  @JsonKey(name: "data")
  DashboardData? data;


  DashboardDataResponse({this.data});

  factory DashboardDataResponse.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDataResponseToJson(this);
}
