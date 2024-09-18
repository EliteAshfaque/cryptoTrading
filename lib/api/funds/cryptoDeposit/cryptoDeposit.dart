import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cryptoDeposit.g.dart';

@JsonSerializable()
class CryptoDepositApiStruct extends Base {

  CryptoDepositApiStruct({required bool success}) : super(result: Result(message: String),
      success: success);

  factory CryptoDepositApiStruct.fromJson(Map<String, dynamic> json) =>  _$CryptoDepositApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$CryptoDepositApiStructToJson(this);
}