import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'withdrawalInr.g.dart';

@JsonSerializable()
class WithdrawalInrApiStruct extends Base {

  WithdrawalInrApiStruct({required bool success}) : super(result: Result(message: WithdrawalInrResp),
      success: success);

  factory WithdrawalInrApiStruct.fromJson(Map<String, dynamic> json) =>  _$WithdrawalInrApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$WithdrawalInrApiStructToJson(this);
}

@JsonSerializable()
class WithdrawalInrResp {

  @JsonKey(name:"authType")
  List<String>? authType;

  @JsonKey(name:"status")
  String? status;

  WithdrawalInrResp({this.status, this.authType});

  factory WithdrawalInrResp.fromJson(Map<String, dynamic> json) =>  _$WithdrawalInrRespFromJson(json);
  Map<String, dynamic> toJson() => _$WithdrawalInrRespToJson(this);

}