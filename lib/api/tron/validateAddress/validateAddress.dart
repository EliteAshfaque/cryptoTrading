import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'validateAddress.g.dart';

@JsonSerializable()
class ValidateAddressApiStruct extends Base {
  ValidateAddressApiStruct({required bool success})
      : super(result: Result(message: bool), success: success);

  factory ValidateAddressApiStruct.fromJson(Map<String, dynamic> json) =>
      _$ValidateAddressApiStructFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateAddressApiStructToJson(this);
}
