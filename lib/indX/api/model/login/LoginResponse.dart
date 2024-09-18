import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'LoginData.dart';

part 'LoginResponse.g.dart';

@JsonSerializable()
class LoginResponse extends BasicResponse{

  @JsonKey(name: "data")
  LoginData? data;

  LoginResponse({this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);




}
