import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'userBank.g.dart';

@JsonSerializable()
class UserBankApiStruct extends Base {

  UserBankApiStruct({required bool success})
      : super(result: Result(message: List<UserBankStruct>),
      success: success);

  factory UserBankApiStruct.fromJson(Map<String, dynamic> json) =>
      _$UserBankApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$UserBankApiStructToJson(this);
}

@JsonSerializable()
class UserBankStruct {

  @JsonKey(name:"active")
  bool? active;

  @JsonKey(name:"accNumber")
  String? accNumber;

  @JsonKey(name:"email")
  String? email;

  @JsonKey(name:"accHolderName")
  String? accHolderName;

  @JsonKey(name:"bankName")
  String? bankName;

  @JsonKey(name:"createdAt")
  String? createdAt;

  @JsonKey(name:"ifsc")
  String? ifsc;

  @JsonKey(name:"status")
  String? status;

  @JsonKey(name:"uniqueId")
  String? uniqueId;

  @JsonKey(name:"utrNo")
  String? utrNo;

  UserBankStruct({this.uniqueId, this.email, this.createdAt, this.status, this.utrNo, this.active,
    this.accHolderName, this.accNumber, this.bankName, this.ifsc});

  factory UserBankStruct.fromJson(Map<String, dynamic> json) =>  _$UserBankStructFromJson(json);
  Map<String, dynamic> toJson() => _$UserBankStructToJson(this);

}

