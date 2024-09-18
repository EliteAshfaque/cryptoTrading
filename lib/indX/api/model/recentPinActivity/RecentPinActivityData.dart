import 'package:json_annotation/json_annotation.dart';

part 'RecentPinActivityData.g.dart';

@JsonSerializable()
class RecentPinActivityData {
  @JsonKey(name: "userID")
  int? userID;
  @JsonKey(name: "ip")
  String? ip;
  @JsonKey(name: "lastLoginIP")
  String? lastLoginIP;
  @JsonKey(name: "entryDate")
  String? entryDate;
  @JsonKey(name: "lastLoginDate")
  String? lastLoginDate;


  RecentPinActivityData(
      {this.userID,
      this.ip,
      this.lastLoginIP,
      this.entryDate,
      this.lastLoginDate});

  factory RecentPinActivityData.fromJson(Map<String, dynamic> json) =>
      _$RecentPinActivityDataFromJson(json);

  Map<String, dynamic> toJson() => _$RecentPinActivityDataToJson(this);
}
