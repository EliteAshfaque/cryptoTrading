import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';
part 'unique_code.g.dart';

@JsonSerializable()
class UniqueCodeStruct extends Base {

  UniqueCodeStruct({required bool success}) : super(result: Result(message: UniqueCode), success: success);

  factory UniqueCodeStruct.fromJson(Map<String, dynamic> json) =>  _$UniqueCodeStructFromJson(json);
  Map<String, dynamic> toJson() => _$UniqueCodeStructToJson(this);
}





@JsonSerializable()
class UniqueCode {
  @JsonKey(name: 'isExpired')
  final bool? isExpired;

  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'paymentMode')
  final String? paymentMode;

  @JsonKey(name: 'uniqueCode')
  final String? uniqueCode;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  @JsonKey(name: 'v')
  final int? v;

  UniqueCode({
    this.isExpired,
    this.id,
    this.paymentMode,
    this.uniqueCode,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UniqueCode.fromJson(Map<String, dynamic> json) => _$UniqueCodeFromJson(json);

  Map<String, dynamic> toJson() => _$UniqueCodeToJson(this);
}

