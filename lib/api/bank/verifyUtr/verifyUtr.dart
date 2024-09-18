import 'package:cryptox/api/bank/userBank/userBank.dart';
import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verifyUtr.g.dart';

@JsonSerializable()
class VerifyUtrApiStruct extends Base {

  VerifyUtrApiStruct({required bool success})
      : super(result: Result(message: UserBankStruct),
      success: success);

  factory VerifyUtrApiStruct.fromJson(Map<String, dynamic> json) =>
      _$VerifyUtrApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyUtrApiStructToJson(this);
}
