import 'package:cryptox/api/user/getUser/getUser.dart';

import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'referral.g.dart';

@JsonSerializable()
class ReferralApiStruct extends Base {

  ReferralApiStruct({required bool success}) : super(result: Result(message: List<IUserStruct>), success: success);

  factory ReferralApiStruct.fromJson(Map<String, dynamic> json) =>  _$ReferralApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$ReferralApiStructToJson(this);
}