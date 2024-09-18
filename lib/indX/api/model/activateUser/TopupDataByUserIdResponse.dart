import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'TopupDataByUserId.dart';

part 'TopupDataByUserIdResponse.g.dart';

@JsonSerializable()
class TopupDataByUserIdResponse extends BasicResponse {
  @JsonKey(name: "stakeType")
  int? stakeType;
  @JsonKey(name: "userID")
  int? userID;
  @JsonKey(name: "data")
  List<TopupDataByUserId>? data;

  TopupDataByUserIdResponse({this.stakeType,this.userID,this.data});

  factory TopupDataByUserIdResponse.fromJson(Map<String, dynamic> json) =>
      _$TopupDataByUserIdResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TopupDataByUserIdResponseToJson(this);
}
