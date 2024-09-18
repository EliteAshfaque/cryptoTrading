
import 'package:json_annotation/json_annotation.dart';
import '../BasicResponse.dart';
import 'RecentPinActivityData.dart';

part 'RecentPinActivityResponse.g.dart';

@JsonSerializable()
class RecentPinActivityResponse extends BasicResponse {
  @JsonKey(name: "data")
  List<RecentPinActivityData>? data;


  RecentPinActivityResponse({this.data});

  factory RecentPinActivityResponse.fromJson(Map<String, dynamic> json) =>
      _$RecentPinActivityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RecentPinActivityResponseToJson(this);
}
