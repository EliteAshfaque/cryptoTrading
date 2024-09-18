import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generateUserAddress.g.dart';

@JsonSerializable()
class GenerateUserAddressApiStruct extends Base {

  GenerateUserAddressApiStruct({required bool success}) : super(result: Result(message: UserAddressStruct),
      success: success);

  factory GenerateUserAddressApiStruct.fromJson(Map<String, dynamic> json) =>  _$GenerateUserAddressApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$GenerateUserAddressApiStructToJson(this);
}

@JsonSerializable()
class UserAddressStruct {

  @JsonKey(name:"address")
  String? address;

  @JsonKey(name:"network")
  String? network;

  @JsonKey(name:"email")
  String? email;

  @JsonKey(name:"uniqueId")
  String? uniqueId;

  @JsonKey(name:"_id")
  String? id;

  UserAddressStruct({this.uniqueId, this.id, this.email, this.address, this.network});

  factory UserAddressStruct.fromJson(Map<String, dynamic> json) =>  _$UserAddressStructFromJson(json);
  Map<String, dynamic> toJson() => _$UserAddressStructToJson(this);

}