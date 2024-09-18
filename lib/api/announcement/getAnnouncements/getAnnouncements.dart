import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'getAnnouncements.g.dart';

@JsonSerializable()
class GetAnnouncementApiStruct extends Base {
  GetAnnouncementApiStruct({required bool success})
      : super(result: Result(message: AnnouncementStruct), success: success);

  factory GetAnnouncementApiStruct.fromJson(Map<String, dynamic> json) =>
      _$GetAnnouncementApiStructFromJson(json);

  Map<String, dynamic> toJson() => _$GetAnnouncementApiStructToJson(this);
}

@JsonSerializable()
class AnnouncementStruct {
  @JsonKey(name: "uniqueId")
  String? uniqueId;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "active")
  bool? active;

  AnnouncementStruct({this.title, this.uniqueId, this.active});

  factory AnnouncementStruct.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementStructFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementStructToJson(this);
}
