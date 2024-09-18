import 'dart:convert';

import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'allRequests.g.dart';

@JsonSerializable()
class AllRequestApiStruct extends Base {
  AllRequestApiStruct({required bool success})
      : super(result: Result(message: AllRequestApiResp), success: success);

  factory AllRequestApiStruct.fromJson(Map<String, dynamic> json) =>
      _$AllRequestApiStructFromJson(json);

  Map<String, dynamic> toJson() => _$AllRequestApiStructToJson(this);
}

@JsonSerializable()
class AllRequestApiResp {
  @JsonKey(name: "data")
  List<RequestStruct>? data;

  @JsonKey(name: "totalCount")
  int? totalCount;

  AllRequestApiResp({this.data, this.totalCount});

  factory AllRequestApiResp.fromJson(Map<String, dynamic> json) =>
      _$AllRequestApiRespFromJson(json);

  Map<String, dynamic> toJson() => _$AllRequestApiRespToJson(this);
}

@JsonSerializable()
class RequestStruct {
  @JsonKey(name: "bankId")
  String? bankId;

  @JsonKey(name: "paymentMode")
  String? paymentMode;

  @JsonKey(name: "utrNo")
  String? utrNo;

  @JsonKey(name: "failedReason")
  String? failedReason;

  @JsonKey(name: "atmNo")
  String? atmNo;

  @JsonKey(name: "txnNo")
  String? txnNo;

  @JsonKey(name: "balance")
  double? balance;

  @JsonKey(name: "docId")
  String? docId;

  @JsonKey(name: "createdAt")
  int? createdAt;

  @JsonKey(name: "updatedAt")
  String? updatedAt;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "uniqueId")
  String? uniqueId;

  @JsonKey(name: "walletId")
  String? walletId;

  @JsonKey(name: "imagePath")
  String? imagePath;

  @JsonKey(name: "remark")
  String? remark;

  RequestStruct(
      {this.balance,
      this.uniqueId,
      this.email,
      this.createdAt,
      this.status,
      this.bankId,
      this.failedReason,
      this.docId,
      this.imagePath,
      this.paymentMode,
      this.utrNo,
      this.walletId,
      this.updatedAt,
      this.atmNo,
      this.txnNo,
      this.remark = ""});

  factory RequestStruct.fromJson(Map<String, dynamic> json) =>
      _$RequestStructFromJson(json);

  Map<String, dynamic> toJson() => _$RequestStructToJson(this);
}
