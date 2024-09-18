import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'allMasterAuth.g.dart';

@JsonSerializable()
class AllMasterAuthApiStruct extends Base {

  AllMasterAuthApiStruct({required bool success})
      : super(result: Result(message: DummyMasterAuthStruct),
      success: success);

  factory AllMasterAuthApiStruct.fromJson(Map<String, dynamic> json) =>
      _$AllMasterAuthApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$AllMasterAuthApiStructToJson(this);
}

@JsonSerializable()
class DummyMasterAuthStruct {

  @JsonKey(name:"google_auth")
  bool? googleAuth;

  @JsonKey(name:"email")
  bool? email;

  @JsonKey(name:"sms")
  bool? sms;

  @JsonKey(name:"none")
  bool? none;

  DummyMasterAuthStruct({ this.email, this.none, this.sms, this.googleAuth});

  factory DummyMasterAuthStruct.fromJson(Map<String, dynamic> json) =>  _$DummyMasterAuthStructFromJson(json);
  Map<String, dynamic> toJson() => _$DummyMasterAuthStructToJson(this);

}

