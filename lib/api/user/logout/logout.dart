import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'logout.g.dart';

@JsonSerializable()
class LogOutApiStruct extends Base {

  LogOutApiStruct({required bool success}) : super(result: String, success: success);

  factory LogOutApiStruct.fromJson(Map<String, dynamic> json) =>  _$LogOutApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$LogOutApiStructToJson(this);
}