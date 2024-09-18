import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sendActiveOtp.g.dart';

@JsonSerializable()
class SendActiveOtpApiStruct extends Base {

  SendActiveOtpApiStruct({required bool success}) : super(result: Result(message: String), success: success);

  factory SendActiveOtpApiStruct.fromJson(Map<String, dynamic> json) =>  _$SendActiveOtpApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$SendActiveOtpApiStructToJson(this);
}