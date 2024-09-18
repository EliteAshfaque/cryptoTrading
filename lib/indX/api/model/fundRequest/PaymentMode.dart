import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';

part 'PaymentMode.g.dart';

@JsonSerializable()
class PaymentMode {
  int? id;
  @JsonKey(name: "bankID")
  int? bankID;
  @JsonKey(name: "modeID")
  int? modeID;
  @JsonKey(name: "isActive")
  bool? isActive;
  @JsonKey(name: "mode")
  String? mode;
  @JsonKey(name: "isTransactionIdAuto")
  bool? isTransactionIdAuto;
  @JsonKey(name: "isAccountHolderRequired")
  bool? isAccountHolderRequired;
  @JsonKey(name: "isChequeNoRequired")
  bool? isChequeNoRequired;
  @JsonKey(name: "isCardNumberRequired")
  bool? isCardNumberRequired;
  @JsonKey(name: "isMobileNoRequired")
  bool? isMobileNoRequired;
  @JsonKey(name: "isBranchRequired")
  bool? isBranchRequired;
  @JsonKey(name: "isUPIID")
  bool? isUPIID;
  @JsonKey(name: "cid")
  String? cid;

  PaymentMode(
      {this.id,
      this.bankID,
      this.modeID,
      this.isActive,
      this.mode,
      this.isTransactionIdAuto,
      this.isAccountHolderRequired,
      this.isChequeNoRequired,
      this.isCardNumberRequired,
      this.isMobileNoRequired,
      this.isBranchRequired,
      this.isUPIID,
      this.cid});

  factory PaymentMode.fromJson(Map<String, dynamic> json) =>
      _$PaymentModeFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentModeToJson(this);
}
