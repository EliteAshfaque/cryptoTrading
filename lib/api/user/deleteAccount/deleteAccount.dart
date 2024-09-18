import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'deleteAccount.g.dart';

@JsonSerializable()
class DeleteAccountApiStruct extends Base {

  DeleteAccountApiStruct({required bool success})
      : super(result: Result(message: String), success: success);

  factory DeleteAccountApiStruct.fromJson(Map<String, dynamic> json) =>
      _$DeleteAccountApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteAccountApiStructToJson(this);
}