import 'package:json_annotation/json_annotation.dart';

part 'DetailsByUserIdResponse.g.dart';

@JsonSerializable()
class DetailsByUserIdResponse {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "mobile")
  String? mobile;
  @JsonKey(name: "emailId")
  String? emailId;
  @JsonKey(name: "msg")
  String? msg;
  @JsonKey(name: "userId")
  int? userId;
  @JsonKey(name: "statuscode")
  int? statuscode;
  @JsonKey(name: "isVersionValid")
  bool? isVersionValid;


  DetailsByUserIdResponse(
      {this.name,
      this.mobile,
      this.emailId,
      this.msg,
      this.userId,
      this.statuscode,
      this.isVersionValid});

  factory DetailsByUserIdResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailsByUserIdResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailsByUserIdResponseToJson(this);
}
