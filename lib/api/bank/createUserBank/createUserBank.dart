import 'package:cryptox/api/bank/userBank/userBank.dart';
import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'createUserBank.g.dart';

@JsonSerializable()
class CreateUserBankApiStruct extends Base {

  CreateUserBankApiStruct({required bool success})
      : super(result: Result(message: UserBankStruct),
      success: success);

  factory CreateUserBankApiStruct.fromJson(Map<String, dynamic> json) =>
      _$CreateUserBankApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$CreateUserBankApiStructToJson(this);
}
