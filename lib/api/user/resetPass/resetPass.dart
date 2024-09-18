import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'resetPass.g.dart';

@JsonSerializable()
class ResetPassApiStruct extends Base {

  ResetPassApiStruct({required bool success}) : super(result: Result(message: String),
      success: success);

  factory ResetPassApiStruct.fromJson(Map<String, dynamic> json) =>  _$ResetPassApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$ResetPassApiStructToJson(this);
}