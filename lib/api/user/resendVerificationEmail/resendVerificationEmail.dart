import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'resendVerificationEmail.g.dart';

@JsonSerializable()
class ResendVerificationEmailApiStruct extends Base {

  ResendVerificationEmailApiStruct({required bool success})
      : super(result: Result(message: String), success: success);

  factory ResendVerificationEmailApiStruct.fromJson(Map<String, dynamic> json) =>
      _$ResendVerificationEmailApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$ResendVerificationEmailApiStructToJson(this);
}