import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../util/Enums.dart';

part 'signUp.g.dart';

@JsonSerializable()
class SignUp extends Base {

  SignUp({required bool success}) : super(result: Result(message: SignUpResult), success: success);

  factory SignUp.fromJson(Map<String, dynamic> json) =>  _$SignUpFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpToJson(this);
}

@JsonSerializable()
class SignUpResult {

  @JsonKey(name:"name")
  String? name;

  @JsonKey(name:"email")
  String? email;

  @JsonKey(name:"phone")
  String? phone;

  @JsonKey(name:"_id")
  String? id;

  @JsonKey(name:"token")
  String? token;

  @JsonKey(name:"uniqueLogId")
  String? uniqueLogId;

  @JsonKey(name:"wallets")
  List<String>? wallets;

  @JsonKey(name:"isAdmin")
  bool? isAdmin;

  @JsonKey(name:"authType")
  MasterAuthType? authType;

  SignUpResult({this.email, this.authType, this.isAdmin, this.name,
    this.id,this.token, this.uniqueLogId, this.wallets, this.phone});

  factory SignUpResult.fromJson(Map<String, dynamic> json) =>  _$SignUpResultFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpResultToJson(this);

}