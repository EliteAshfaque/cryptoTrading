import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';

part 'CryptoTransferRequest.g.dart';

@JsonSerializable()
class CryptoTransferRequest {



  @JsonKey(name: "OTP")
  String? OTP;
  @JsonKey(name: "ReferenceId")
  int? ReferenceId;
  @JsonKey(name: "Amount")
  String? Amount;
  @JsonKey(name: "FromCurrId")
  int? FromCurrId;
  @JsonKey(name: "OTPType")
  int? OTPType;
  @JsonKey(name: "ToWalletId")
  int? ToWalletId;
  @JsonKey(name: "TransferType")
  int? TransferType;
  @JsonKey(name: "FromUserId")
  int? FromUserId;
  @JsonKey(name: "ToAddress")
  String? ToAddress;


  CryptoTransferRequest(
      {this.OTP,
      this.ReferenceId,
      this.Amount,
      this.FromCurrId,
      this.OTPType,
      this.ToWalletId,
      this.TransferType,
      this.FromUserId,
      this.ToAddress});

  factory CryptoTransferRequest.fromJson(Map<String, dynamic> json) =>
      _$CryptoTransferRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoTransferRequestToJson(this);
}
