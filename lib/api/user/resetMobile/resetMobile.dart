import 'package:cryptox/api/base.dart';
import 'package:cryptox/api/user/getUser/getUser.dart';
import 'package:json_annotation/json_annotation.dart';

part 'resetMobile.g.dart';

@JsonSerializable()
class ResetMobileApiStruct extends Base {

  ResetMobileApiStruct({required bool success})
      : super(result: Result(message: IUserStruct),
      success: success);

  factory ResetMobileApiStruct.fromJson(Map<String, dynamic> json) =>
      _$ResetMobileApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$ResetMobileApiStructToJson(this);
}
