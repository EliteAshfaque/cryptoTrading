import 'package:cryptox/api/base.dart';
import 'package:cryptox/api/user/getUser/getUser.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verifyTOtp.g.dart';

@JsonSerializable()
class VerifyTOtpApiStruct extends Base {

  VerifyTOtpApiStruct({required bool success}) : super(result: Result(message: IUserStruct), success: success);

  factory VerifyTOtpApiStruct.fromJson(Map<String, dynamic> json) =>  _$VerifyTOtpApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyTOtpApiStructToJson(this);
}