import 'package:cryptox/api/base.dart';
import 'package:cryptox/api/kyc/kycId/kycId.dart';
import 'package:json_annotation/json_annotation.dart';

part 'submitKyc.g.dart';

@JsonSerializable()
class SubmitKycApiStruct extends Base {
  SubmitKycApiStruct({required bool success})
      : super(result: Result(message: KycStruct), success: success);

  factory SubmitKycApiStruct.fromJson(Map<String, dynamic> json) =>
      _$SubmitKycApiStructFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitKycApiStructToJson(this);
}
