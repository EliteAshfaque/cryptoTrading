import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activityLogs.g.dart';

@JsonSerializable()
class ActivityLogsApiStruct extends Base {

  ActivityLogsApiStruct({required bool success}) : super(result: Result(message: List<ActivityLogsStruct>),
      success: success);

  factory ActivityLogsApiStruct.fromJson(Map<String, dynamic> json) =>  _$ActivityLogsApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityLogsApiStructToJson(this);
}

@JsonSerializable()
class ActivityLogsStruct {

  @JsonKey(name:"loginTime")
  int? loginTime;

  @JsonKey(name:"browser")
  String? browser;

  @JsonKey(name:"city")
  String? city;

  @JsonKey(name:"country")
  String? country;

  @JsonKey(name:"createdAt")
  int? createdAt;

  @JsonKey(name:"email")
  String? email;

  @JsonKey(name:"ip")
  String? ip;

  @JsonKey(name:"lat")
  String? lat;

  @JsonKey(name:"long")
  String? long;

  @JsonKey(name:"os")
  String? os;

  @JsonKey(name:"status")
  String? status;

  @JsonKey(name:"timezone")
  String? timezone;

  @JsonKey(name:"uniqueId")
  String? uniqueId;

  @JsonKey(name:"message")
  String? message;

  @JsonKey(name:"type")
  String? type;

  ActivityLogsStruct({this.uniqueId, this.type, this.email, this.status, this.createdAt, this.country,
    this.city, this.message, this.browser, this.ip, this.lat, this.loginTime, this.long, this.os,
      this.timezone});

  factory ActivityLogsStruct.fromJson(Map<String, dynamic> json) =>  _$ActivityLogsStructFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityLogsStructToJson(this);

}

