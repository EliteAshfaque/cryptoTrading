import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';

part 'UserDetailRank.g.dart';

@JsonSerializable()
class UserDetailRank  {
  @JsonKey(name: "rankName")
  String? rankName;
  @JsonKey(name: "rankImage")
  String? rankImage;
  @JsonKey(name: "bussinessCurrSymbol")
  String? bussinessCurrSymbol;
  @JsonKey(name: "bussinessCurrImage")
  String? bussinessCurrImage;
  @JsonKey(name: "bussinessCurrName")
  String? bussinessCurrName;
  @JsonKey(name: "bussinessCurrId")
  int? bussinessCurrId;
  @JsonKey(name: "toupAmount")
  double? toupAmount;


  UserDetailRank(
      {this.rankName,
      this.rankImage,
      this.bussinessCurrSymbol,
      this.bussinessCurrImage,
      this.bussinessCurrName,
      this.bussinessCurrId,
      this.toupAmount});

  factory UserDetailRank.fromJson(Map<String, dynamic> json) =>
      _$UserDetailRankFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailRankToJson(this);
}
