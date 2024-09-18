import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'enableAuth.g.dart';

@JsonSerializable()
class EnableAuthApiStruct extends Base {

  EnableAuthApiStruct({required bool success}) : super(result: Result(message: MasterAuthStruct), success: success);

  factory EnableAuthApiStruct.fromJson(Map<String, dynamic> json) =>  _$EnableAuthApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$EnableAuthApiStructToJson(this);
}

@JsonSerializable()
class MasterAuthStruct {

  @JsonKey(name:"isEmailReq")
  bool? isEmailReq;

  @JsonKey(name:"isSmsReq")
  bool? isSmsReq;

  @JsonKey(name:"isgAuthReq")
  bool? isgAuthReq;

  @JsonKey(name:"type")
  String? type;

  @JsonKey(name:"uniqueId")
  String? uniqueId;

  @JsonKey(name:"active")
  bool? active;

  MasterAuthStruct({this.uniqueId, this.active, this.type, this.isEmailReq, this.isgAuthReq, this.isSmsReq});

  factory MasterAuthStruct.fromJson(Map<String, dynamic> json) =>  _$MasterAuthStructFromJson(json);
  Map<String, dynamic> toJson() => _$MasterAuthStructToJson(this);

}

