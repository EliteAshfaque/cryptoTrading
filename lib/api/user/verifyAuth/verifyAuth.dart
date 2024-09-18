import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verifyAuth.g.dart';

@JsonSerializable()
class VerifyAuthApiStruct extends Base {

  VerifyAuthApiStruct({required bool success}) : super(result: Result(message: VerifyAuthStruct), success: success);

  factory VerifyAuthApiStruct.fromJson(Map<String, dynamic> json) =>  _$VerifyAuthApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyAuthApiStructToJson(this);
}

@JsonSerializable()
class VerifyAuthStruct {

  @JsonKey(name:"type")
  String? type;

  @JsonKey(name:"data")
  dynamic data;

  VerifyAuthStruct({this.type, this.data});

  factory VerifyAuthStruct.fromJson(Map<String, dynamic> json) =>  _$VerifyAuthStructFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyAuthStructToJson(this);

}