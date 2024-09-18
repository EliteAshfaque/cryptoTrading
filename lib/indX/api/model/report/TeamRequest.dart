import 'package:json_annotation/json_annotation.dart';
import '../BasicRequest.dart';

part 'TeamRequest.g.dart';

@JsonSerializable()
class TeamRequest {

  @JsonKey(name: "FromDate")
  String? FromDate;
  @JsonKey(name: "ToDate")
  String? ToDate;
  @JsonKey(name: "Leg")
  String? Leg;
  @JsonKey(name: "LevelNo")
  String? LevelNo;
  @JsonKey(name: "Status")
  String? Status;


  TeamRequest(
      {this.FromDate, this.ToDate, this.Leg, this.LevelNo, this.Status});

  factory TeamRequest.fromJson(Map<String, dynamic> json) =>
      _$TeamRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TeamRequestToJson(this);
}
