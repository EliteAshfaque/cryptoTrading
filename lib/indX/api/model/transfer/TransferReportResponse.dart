import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'SendMoneyBankReport.dart';
import 'WithdrawalWalletReport.dart';

part 'TransferReportResponse.g.dart';

@JsonSerializable()
class TransferReportResponse extends BasicResponse{
  @JsonKey(name: "withdrawalWalletReport")
  List<WithdrawalWalletReport>? withdrawalWalletReport;
  @JsonKey(name: "withdrawalCryptoReport")
  List<WithdrawalWalletReport>? withdrawalCryptoReport;
  @JsonKey(name: "dmtReport")
  List<SendMoneyBankReport>? dmtReport;


  TransferReportResponse(
      {this.withdrawalWalletReport,this.withdrawalCryptoReport,this.dmtReport});

  factory TransferReportResponse.fromJson(Map<String, dynamic> json) =>
      _$TransferReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransferReportResponseToJson(this);
}
