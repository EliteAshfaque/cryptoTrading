import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'changePassword.g.dart';

@JsonSerializable()
class ChangePasswordApiStruct extends Base {

  ChangePasswordApiStruct({required bool success})
      : super(result: Result(message: String), success: success);

  factory ChangePasswordApiStruct.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$ChangePasswordApiStructToJson(this);
}