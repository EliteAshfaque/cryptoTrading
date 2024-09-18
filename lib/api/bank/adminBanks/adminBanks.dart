import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'adminBanks.g.dart';

@JsonSerializable()
class AdminBanksApiStruct extends Base {

  AdminBanksApiStruct({required bool success})
      : super(result: Result(message: List<AdminBanksStruct>),
      success: success);

  factory AdminBanksApiStruct.fromJson(Map<String, dynamic> json) =>
      _$AdminBanksApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$AdminBanksApiStructToJson(this);
}

@JsonSerializable()
class AdminBanksStruct {

  @JsonKey(name:"status")
  String? status;

  @JsonKey(name:"paymentModes")
  List<String>? paymentModes;

  @JsonKey(name:"bankName")
  String? bankName;

  @JsonKey(name:"email")
  String? email;

  @JsonKey(name:"accHolderName")
  String? accHolderName;

  @JsonKey(name:"createdAt")
  int? createdAt;

  @JsonKey(name:"ifsc")
  String? ifsc;

  @JsonKey(name:"accNumber")
  String? accNumber;

  @JsonKey(name:"_id")
  String? id;

  AdminBanksStruct({this.createdAt, this.status, this.email, this.accNumber, this.bankName, this.ifsc,
    this.accHolderName, this.paymentModes, this.id});

  factory AdminBanksStruct.fromJson(Map<String, dynamic> json) =>  _$AdminBanksStructFromJson(json);
  Map<String, dynamic> toJson() => _$AdminBanksStructToJson(this);

}

