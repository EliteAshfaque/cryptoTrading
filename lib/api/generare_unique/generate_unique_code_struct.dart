import 'package:json_annotation/json_annotation.dart';

import '../base.dart';

part 'generate_unique_code_struct.g.dart';

@JsonSerializable()
class GenerateUnique extends Base {
  GenerateUnique({required bool success})
      : super(
            result: Result(message: GenerateUniqueCodeStruct),
            success: success);

  factory GenerateUnique.fromJson(Map<String, dynamic> json) =>
      _$GenerateUniqueFromJson(json);

  Map<String, dynamic> toJson() => _$GenerateUniqueToJson(this);
}

@JsonSerializable()
class GenerateUniqueCodeStruct {
  String message;

  GenerateUniqueCodeStruct({
    required this.message,
  });

  factory GenerateUniqueCodeStruct.fromJson(Map<String, dynamic> json) =>
      _$GenerateUniqueCodeStructFromJson(json);

  Map<String, dynamic> toJson() => _$GenerateUniqueCodeStructToJson(this);
}
