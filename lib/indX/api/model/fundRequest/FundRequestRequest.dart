
import 'package:json_annotation/json_annotation.dart';

import '../BasicRequest.dart';
part 'FundRequestRequest.g.dart';
@JsonSerializable()
class FundRequestRequest extends BasicRequest{
  @JsonKey(name: "orderID")
  String? orderID;
  @JsonKey(name: "upiid")
  String? upiid;
  @JsonKey(name: "checksum")
  String? checksum;
  @JsonKey(name: "bankID")
  int? bankID;
  @JsonKey(name: "amount")
  String? amount;
  @JsonKey(name: "transactionID")
  String? transactionID;
  @JsonKey(name: "mobileNo")
  String? mobileNo;
  @JsonKey(name: "chequeNo")
  String? chequeNo;
  @JsonKey(name: "cardNo")
  String? cardNo;
  @JsonKey(name: "accountHolderName")
  String? accountHolderName;
  @JsonKey(name: "accountNumber")
  String? accountNumber;
  @JsonKey(name: "isImage")
  int? isImage;
  @JsonKey(name: "paymentID")
  int? paymentID;
  @JsonKey(name: "walletTypeID")
  int? walletTypeID;


  FundRequestRequest(
      this.orderID,
      this.upiid,
      this.checksum,
      this.bankID,
      this.amount,
      this.transactionID,
      this.mobileNo,
      this.chequeNo,
      this.cardNo,
      this.accountHolderName,
      this.accountNumber,
      this.isImage,
      this.paymentID,
      this.walletTypeID,super.loginTypeID, super.userID, super.session, super.sessionID, super.appid, super.imei, super.regKey, super.version, super.serialNo);

  factory FundRequestRequest.fromJson(Map<String, dynamic> json) =>
      _$FundRequestRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FundRequestRequestToJson(this);
}
