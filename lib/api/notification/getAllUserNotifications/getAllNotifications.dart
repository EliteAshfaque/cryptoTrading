import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'getAllNotifications.g.dart';

@JsonSerializable()
class GetAllNotificationsApiStruct extends Base {

  GetAllNotificationsApiStruct({required bool success})
      : super(result: Result(message: List<MobileNotificationsStruct>),
      success: success);

  factory GetAllNotificationsApiStruct.fromJson(Map<String, dynamic> json) =>
      _$GetAllNotificationsApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$GetAllNotificationsApiStructToJson(this);
}

@JsonSerializable()
class MobileNotificationsStruct {

  @JsonKey(name:"email")
  String? email;

  @JsonKey(name:"title")
  String? title;

  @JsonKey(name:"body")
  String? body;

  @JsonKey(name:"uniqueId")
  String? uniqueId;

  @JsonKey(name:"imageUrl")
  String? imageUrl;

  @JsonKey(name:"createdAt")
  String? createdAt;

  @JsonKey(name:"updatedAt")
  String? updatedAt;

  @JsonKey(name:"opened")
  bool? opened;

  @JsonKey(name:"ip")
  String? ip;

  @JsonKey(name:"device")
  String? device;

  MobileNotificationsStruct({ this.email, this.body, this.title, this.createdAt, this.uniqueId,
    this.updatedAt, this.imageUrl, this.opened});

  factory MobileNotificationsStruct.fromJson(Map<String, dynamic> json) =>
      _$MobileNotificationsStructFromJson(json);
  Map<String, dynamic> toJson() => _$MobileNotificationsStructToJson(this);

}

