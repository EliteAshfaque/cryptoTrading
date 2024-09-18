import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'CompanyProfileData.dart';

part 'CompanyProfileResponse.g.dart';

@JsonSerializable()
class CompanyProfileResponse extends BasicResponse{
  @JsonKey(name: "companyProfile")
  CompanyProfileData? companyProfile;


  CompanyProfileResponse({this.companyProfile});

  factory CompanyProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$CompanyProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyProfileResponseToJson(this);
}
