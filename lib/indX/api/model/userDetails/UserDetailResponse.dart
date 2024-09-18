import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'UserDetail.dart';

part 'UserDetailResponse.g.dart';

@JsonSerializable()
class UserDetailResponse extends BasicResponse {
  @JsonKey(name: "userInfo")
  UserDetail? userInfo;


  UserDetailResponse({this.userInfo});

  factory UserDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailResponseToJson(this);
}
