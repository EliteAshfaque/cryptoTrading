import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refreshMobileToken.g.dart';

@JsonSerializable()
class RefreshMobilTokenApiStruct extends Base {

  RefreshMobilTokenApiStruct({required bool success}) : super(result: Result(message: String),
      success: success);

  factory RefreshMobilTokenApiStruct.fromJson(Map<String, dynamic> json) =>  _$RefreshMobilTokenApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$RefreshMobilTokenApiStructToJson(this);
}