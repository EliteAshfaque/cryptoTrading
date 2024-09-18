import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'IncomeReport.dart';
import 'LedgerReport.dart';
import 'ReportData.dart';

part 'ReportResponse.g.dart';

@JsonSerializable()
class ReportResponse extends BasicResponse{
  @JsonKey(name: "ledgerReport")
  List<LedgerReport>? ledgerReport;
  @JsonKey(name: "data")
  List<ReportData>? data;
  @JsonKey(name: "incomeWiseReport")
  List<IncomeReport>? incomeWiseReport;

  ReportResponse({this.ledgerReport,this.data,this.incomeWiseReport});

  factory ReportResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportResponseToJson(this);
}
