import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';

part 'WithdrawalReportRequest.g.dart';

@JsonSerializable()
class WithdrawalReportRequest {

  @JsonKey(name: "CurrencyId")
  int? CurrencyId;
  @JsonKey(name: "FromDate")
  String? FromDate;
  @JsonKey(name: "ToDate")
  String? ToDate;
  @JsonKey(name: "WalletId")
  int? WalletId;


  WithdrawalReportRequest(
      {this.CurrencyId, this.FromDate, this.ToDate, this.WalletId});

  factory WithdrawalReportRequest.fromJson(Map<String, dynamic> json) =>
      _$WithdrawalReportRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawalReportRequestToJson(this);
}
