import 'package:json_annotation/json_annotation.dart';

part 'SwapReportData.g.dart';

@JsonSerializable()
class SwapReportData {
  @JsonKey(name: "swappingId")
  int? swappingId;
  @JsonKey(name: "swappingWalletId")
  int? swappingWalletId;
  @JsonKey(name: "tid")
  int? tid;
  @JsonKey(name: "userId")
  int? userId;
  @JsonKey(name: "struserId")
  String? struserId;
  @JsonKey(name: "userName")
  String? userName;
  @JsonKey(name: "fromCurrency")
  String? fromCurrency;
  @JsonKey(name: "toCurrency")
  String? toCurrency;
  @JsonKey(name: "transAmount")
  double? transAmount;
  @JsonKey(name: "convRate")
  double? convRate;
  @JsonKey(name: "convertAmount")
  double? convertAmount;
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "status2")
  int? status2;
  @JsonKey(name: "statusType")
  String? statusType;
  @JsonKey(name: "statusType2")
  String? statusType2;
  @JsonKey(name: "hashValue")
  String? hashValue;
  @JsonKey(name: "hashValue2")
  String? hashValue2;
  @JsonKey(name: "requestTime")
  String? requestTime;
  @JsonKey(name: "isAdminApproval")
  bool? isAdminApproval;

  SwapReportData(
      {this.swappingId,
      this.swappingWalletId,
      this.tid,
      this.userId,
      this.struserId,
      this.userName,
      this.fromCurrency,
      this.toCurrency,
      this.transAmount,
      this.convRate,
      this.convertAmount,
      this.status,
      this.status2,
      this.statusType,
      this.statusType2,
      this.hashValue,
      this.hashValue2,
      this.requestTime,
      this.isAdminApproval});

  factory SwapReportData.fromJson(Map<String, dynamic> json) =>
      _$SwapReportDataFromJson(json);

  Map<String, dynamic> toJson() => _$SwapReportDataToJson(this);
}
