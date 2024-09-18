import 'package:cryptox/api/base.dart';
import 'package:cryptox/api/funds/withdrawalinr/withdrawalInr.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cryptoWithdrawal.g.dart';

@JsonSerializable()
class CryptoWithdrawalApiStruct extends Base {

  CryptoWithdrawalApiStruct({required bool success}) : super(result: Result(message: WithdrawalInrResp),
      success: success);

  factory CryptoWithdrawalApiStruct.fromJson(Map<String, dynamic> json) =>  _$CryptoWithdrawalApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$CryptoWithdrawalApiStructToJson(this);
}