import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import '../banner/Banners.dart';
import 'CompanyProfileData.dart';

part 'ReferralContentResponse.g.dart';

@JsonSerializable()
class ReferralContentResponse extends BasicResponse{

  @JsonKey(name:"refferalContent")
   String? refferalContent;
  @JsonKey(name:"refferalLink")
   String? refferalLink;
  @JsonKey(name:"refferalImage")
   List<Banners>? refferalImage;


  ReferralContentResponse(
      {this.refferalContent, this.refferalLink, this.refferalImage});

  factory ReferralContentResponse.fromJson(Map<String, dynamic> json) =>
      _$ReferralContentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReferralContentResponseToJson(this);
}
