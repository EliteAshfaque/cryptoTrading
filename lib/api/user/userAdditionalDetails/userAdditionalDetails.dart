import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'userAdditionalDetails.g.dart';

@JsonSerializable()
class UserAdditionalDetailsApiStruct extends Base {

  UserAdditionalDetailsApiStruct({required bool success}) : super(result: Result(message: UserDetailsStruct), success: success);

  factory UserAdditionalDetailsApiStruct.fromJson(Map<String, dynamic> json) =>  _$UserAdditionalDetailsApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$UserAdditionalDetailsApiStructToJson(this);
}

@JsonSerializable()
class UserDetailsStruct {

  @JsonKey(name:"email")
  String? email;

  @JsonKey(name:"address")
  String? address;

  @JsonKey(name:"city")
  String? city;

  @JsonKey(name:"country")
  String? country;

  @JsonKey(name:"postalCode")
  String? postalCode;

  @JsonKey(name:"state")
  String? state;

  @JsonKey(name:"uniqueId")
  String? uniqueId;

  @JsonKey(name:"phone")
  String? phone;

  @JsonKey(name:"name")
  String? name;

  @JsonKey(name:"kycVerified")
  bool? kycVerified;

  UserDetailsStruct({this.phone, this.email, this.name, this.uniqueId, this.address, this.city,
    this.country, this.kycVerified, this.postalCode, this.state});

  factory UserDetailsStruct.fromJson(Map<String, dynamic> json) =>  _$UserDetailsStructFromJson(json);
  Map<String, dynamic> toJson() => _$UserDetailsStructToJson(this);

}