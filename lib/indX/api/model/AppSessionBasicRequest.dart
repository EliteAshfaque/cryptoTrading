import 'package:json_annotation/json_annotation.dart';

import 'BasicRequest.dart';
part 'AppSessionBasicRequest.g.dart';
@JsonSerializable()
class AppSessionBasicRequest{

  @JsonKey(name: "appSession")
  BasicRequest? appSession;
  @JsonKey(name: "Request")
  dynamic request;

  AppSessionBasicRequest(
      {this.appSession,this.request});

  factory AppSessionBasicRequest.fromJson(Map<String, dynamic> json) =>
      _$AppSessionBasicRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AppSessionBasicRequestToJson(this);
}
