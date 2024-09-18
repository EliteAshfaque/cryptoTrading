import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'updateNotification.g.dart';

@JsonSerializable()
class UpdateNotificationsApiStruct extends Base {

  UpdateNotificationsApiStruct({required bool success})
      : super(result: Result(message: String),
      success: success);

  factory UpdateNotificationsApiStruct.fromJson(Map<String, dynamic> json) =>
      _$UpdateNotificationsApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateNotificationsApiStructToJson(this);
}

