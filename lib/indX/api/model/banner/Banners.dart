import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';

part 'Banners.g.dart';

@JsonSerializable()
class Banners {
  @JsonKey(name: "resourceUrl")
  String? resourceUrl;
  @JsonKey(name: "siteResourceUrl")
  String? siteResourceUrl;
  @JsonKey(name: "siteFileName")
  String? siteFileName;
  @JsonKey(name: "popupResourceUrl")
  String? popupResourceUrl;
  @JsonKey(name: "popupFileName")
  String? popupFileName;
  @JsonKey(name: "fileName")
  String? fileName;

  Banners(
      {this.resourceUrl,
      this.siteResourceUrl,
      this.siteFileName,
      this.popupResourceUrl,
      this.popupFileName,
      this.fileName});

  factory Banners.fromJson(Map<String, dynamic> json) => _$BannersFromJson(json);

  Map<String, dynamic> toJson() => _$BannersToJson(this);
}
