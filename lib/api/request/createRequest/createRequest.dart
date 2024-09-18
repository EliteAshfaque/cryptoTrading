import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'createRequest.g.dart';

@JsonSerializable()
class CreateRequestApiStruct extends Base {

  CreateRequestApiStruct({required bool success})
      : super(result: Result(message: FiatRequestStruct),
      success: success);

  factory CreateRequestApiStruct.fromJson(Map<String, dynamic> json) =>
      _$CreateRequestApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$CreateRequestApiStructToJson(this);
}

@JsonSerializable()
class FiatRequestStruct {

  @JsonKey(name:"createdAt")
  int? createdAt;

  @JsonKey(name:"email")
  String? email;

  @JsonKey(name:"balance")
  int? balance;

  @JsonKey(name:"status")
  String? status;

  @JsonKey(name:"uniqueId")
  String? uniqueId;

  @JsonKey(name:"walletId")
  String? walletId;

  @JsonKey(name:"utrNo")
  String? utrNo;

  @JsonKey(name:"bankId")
  String? bankId;

  @JsonKey(name:"paymentMode")
  String? paymentMode;

  @JsonKey(name:"docId")
  String? docId;

  @JsonKey(name:"failedReason")
  String? failedReason;

  FiatRequestStruct({this.createdAt, this.status, this.email, this.bankId, this.utrNo, this.failedReason,
    this.uniqueId, this.balance, this.walletId, this.paymentMode, this.docId});

  factory FiatRequestStruct.fromJson(Map<String, dynamic> json) =>  _$FiatRequestStructFromJson(json);
  Map<String, dynamic> toJson() => _$FiatRequestStructToJson(this);

}

