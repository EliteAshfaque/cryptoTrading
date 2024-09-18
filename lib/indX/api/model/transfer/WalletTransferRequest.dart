import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';

part 'WalletTransferRequest.g.dart';

@JsonSerializable()
class WalletTransferRequest {
  @JsonKey(name: "ExternalAddress")
  String? ExternalAddress;
  @JsonKey(name: "OTP")
  String? OTP;
  @JsonKey(name: "OTPRefId")
  int? OTPRefId;
  @JsonKey(name: "OTPType")
  int? OTPType;
  @JsonKey(name: "ToUserId")
  int? ToUserId;
  @JsonKey(name: "Amount")
  String? Amount;
  @JsonKey(name: "ToWithdrwalType")
  int? ToWithdrwalType;
  @JsonKey(name: "ToWalletId")
  int? ToWalletId;
  @JsonKey(name: "FromWalletId")
  int? FromWalletId;

  WalletTransferRequest(
      {this.ExternalAddress,
      this.OTP,
      this.OTPRefId,
      this.OTPType,
      this.ToUserId,
      this.Amount,
      this.ToWithdrwalType,
      this.ToWalletId,
      this.FromWalletId});

  factory WalletTransferRequest.fromJson(Map<String, dynamic> json) =>
      _$WalletTransferRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WalletTransferRequestToJson(this);
}
