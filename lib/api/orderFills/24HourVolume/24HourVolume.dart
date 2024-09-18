import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part '24HourVolume.g.dart';

@JsonSerializable()
class Last24HourVolumeApiStruct extends Base {

  Last24HourVolumeApiStruct({required bool success})
      : super(result: Result(message: String),
      success: success);

  factory Last24HourVolumeApiStruct.fromJson(Map<String, dynamic> json) =>
      _$Last24HourVolumeApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$Last24HourVolumeApiStructToJson(this);
}

