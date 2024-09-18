import 'package:cryptox/api/base.dart';
import 'package:cryptox/api/user/getUser/getUser.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verifyActiveOtp.g.dart';

@JsonSerializable()
class VerifyActiveOtpApiStruct extends Base {

  VerifyActiveOtpApiStruct({required bool success}) : super(result: Result(message: IUserStruct), success: success);

  factory VerifyActiveOtpApiStruct.fromJson(Map<String, dynamic> json) =>  _$VerifyActiveOtpApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyActiveOtpApiStructToJson(this);
}