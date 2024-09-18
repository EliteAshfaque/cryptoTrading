import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'FundRequestReport.dart';

part 'FundRequestReportResponse.g.dart';

@JsonSerializable()
class FundRequestReportResponse extends BasicResponse{
  @JsonKey(name: "data")
  List<FundRequestReport>? data;


  FundRequestReportResponse(
      {this.data});

  factory FundRequestReportResponse.fromJson(Map<String, dynamic> json) =>
      _$FundRequestReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FundRequestReportResponseToJson(this);
}
