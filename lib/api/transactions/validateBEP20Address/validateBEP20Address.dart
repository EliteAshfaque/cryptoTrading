import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'validateBEP20Address.g.dart';

@JsonSerializable()
class ValidateBEP20AddressApiStruct extends Base {

  ValidateBEP20AddressApiStruct({required bool success})
      : super(result: Result(message: bool),
      success: success);

  factory ValidateBEP20AddressApiStruct.fromJson(Map<String, dynamic> json) =>
      _$ValidateBEP20AddressApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$ValidateBEP20AddressApiStructToJson(this);
}

