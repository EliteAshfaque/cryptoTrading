 import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bankList.g.dart';

@JsonSerializable()
class BankListApiStruct extends Base {

  BankListApiStruct({required bool success})
      : super(result: Result(message: List<BankListStruct>),
      success: success);

  factory BankListApiStruct.fromJson(Map<String, dynamic> json) =>
      _$BankListApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$BankListApiStructToJson(this);
}

@JsonSerializable()
class BankListStruct {

  @JsonKey(name:"bankId")
  String? bankId;

  @JsonKey(name:"bankName")
  String? bankName;

  @JsonKey(name:"ifsc")
  String? ifsc;

  @JsonKey(name:"createdAt")
  String? createdAt;

  BankListStruct({this.bankName, this.ifsc, this.createdAt, this.bankId});

  factory BankListStruct.fromJson(Map<String, dynamic> json) =>  _$BankListStructFromJson(json);
  Map<String, dynamic> toJson() => _$BankListStructToJson(this);

}

