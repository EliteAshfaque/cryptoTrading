import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'getBanner.g.dart';

@JsonSerializable()
class GetBannerApiStruct extends Base {

  GetBannerApiStruct({required bool success})
      : super(result: Result(message: BannerStruct),
      success: success);

  factory GetBannerApiStruct.fromJson(Map<String, dynamic> json) =>
      _$GetBannerApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$GetBannerApiStructToJson(this);
}


@JsonSerializable()
class BannerStruct {

  @JsonKey(name:"uniqueId")
  String? uniqueId;

  @JsonKey(name:"title")
  String? title;

  @JsonKey(name:"action")
  String? action;

  @JsonKey(name:"imgUrl")
  String? imgUrl;

  @JsonKey(name:"createdAt")
  String? createdAt;

  @JsonKey(name:"updatedAt")
  String? updatedAt;

  BannerStruct({this.uniqueId, this.createdAt, this.title, this.updatedAt, this.action,
    this.imgUrl});

  factory BannerStruct.fromJson(Map<String, dynamic> json) =>  _$BannerStructFromJson(json);
  Map<String, dynamic> toJson() => _$BannerStructToJson(this);

}
