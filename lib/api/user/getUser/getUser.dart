import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'getUser.g.dart';

@JsonSerializable()
class UserDetailsApiStruct extends Base {

  UserDetailsApiStruct({required bool success}) : super(result: Result(message: IUserStruct), success: success);

  factory UserDetailsApiStruct.fromJson(Map<String, dynamic> json) =>  _$UserDetailsApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$UserDetailsApiStructToJson(this);
}

@JsonSerializable()
class IUserStruct {

  @JsonKey(name:"_id")
  String? id;

  @JsonKey(name:"trialActivated")
  bool? trialActivated;

  @JsonKey(name:"canWithdrawal")
  bool? canWithdrawal;

  @JsonKey(name:"canDeposit")
  bool? canDeposit;

  @JsonKey(name:"active")
  bool? active;

  @JsonKey(name:"authType")
  String? authType;

  @JsonKey(name:"kycVerificationId")
  String? kycVerificationId;

  @JsonKey(name:"kycVerified")
  bool? kycVerified;

  @JsonKey(name:"isAdmin")
  bool? isAdmin;

  @JsonKey(name:"name")
  String? name;

  @JsonKey(name:"email")
  String? email;

  @JsonKey(name:"phone")
  String? phone;

  @JsonKey(name:"lastSendEmailOtp")
  String? lastSendEmailOtp;

  @JsonKey(name:"createdAt")
  String? createdAt;

  @JsonKey(name:"uniqueId")
  String? uniqueId;

  IUserStruct({this.phone, this.email, this.name,this.kycVerified, this.active, this.canWithdrawal,
    this.canDeposit, this.authType, this.isAdmin, this.trialActivated, this.kycVerificationId,
    this.lastSendEmailOtp, this.id, this.createdAt, this.uniqueId});

  factory IUserStruct.fromJson(Map<String, dynamic> json) =>  _$IUserStructFromJson(json);
  Map<String, dynamic> toJson() => _$IUserStructToJson(this);

}