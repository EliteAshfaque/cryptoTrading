
import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'SwapReportData.dart';

part 'SwapReportResponse.g.dart';

@JsonSerializable()
class SwapReportResponse extends BasicResponse {

  @JsonKey(name: "swapReport")
  List<SwapReportData>? swapReport;

  SwapReportResponse({this.swapReport});

  factory SwapReportResponse.fromJson(Map<String, dynamic> json) =>
      _$SwapReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SwapReportResponseToJson(this);
}
