import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../util/Enums.dart';

part 'login.g.dart';

@JsonSerializable()
class Login extends Base {

  Login({required bool success}) : super(result: Result(message: LoginResult), success: success);

  factory Login.fromJson(Map<String, dynamic> json) =>  _$LoginFromJson(json);
  Map<String, dynamic> toJson() => _$LoginToJson(this);
}

@JsonSerializable()
class LoginResult {

  @JsonKey(name:"name")
  String? name;

  @JsonKey(name:"email")
  String? email;

  @JsonKey(name:"countryCode")
  int? countryCode;

  @JsonKey(name:"phone")
  String? phone;

  @JsonKey(name:"token")
  String? token;

  @JsonKey(name:"uniqueLogId")
  String? uniqueLogId;

  @JsonKey(name:"status")
  LoginStatus? status;

  @JsonKey(name:"wallets")
  List<String>? wallets;

  @JsonKey(name:"isAdmin")
  bool? isAdmin;

  @JsonKey(name:"isDeleteApproval")
  bool? isDeleteApproval;

  @JsonKey(name:"active")
  bool? active;

  @JsonKey(name:"authType")
  MasterAuthType? authType;

  LoginResult({this.email, this.authType, this.isAdmin, this.name, this.status, this.active,
   this.token, this.uniqueLogId, this.wallets, this.countryCode,this.phone, this.isDeleteApproval});

  factory LoginResult.fromJson(Map<String, dynamic> json) =>  _$LoginResultFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResultToJson(this);

}