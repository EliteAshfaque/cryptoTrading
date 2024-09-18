import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'CompanyProfileData.dart';

part 'Google2FAResponse.g.dart';

@JsonSerializable()
class Google2FAResponse extends BasicResponse {
  @JsonKey(name: "referenceId")
  int? referenceId;
  @JsonKey(name: "accountSecretKey")
  String? accountSecretKey;
  @JsonKey(name: "qrCodeSetupImageUrl")
  String? qrCodeSetupImageUrl;
  @JsonKey(name: "qrCodeSetupKey")
  String? qrCodeSetupKey;
  @JsonKey(name: "alreadyRegistered")
  bool? alreadyRegistered;
  @JsonKey(name: "isEnabled")
  bool? isEnabled;


  Google2FAResponse(
      {this.referenceId,
      this.accountSecretKey,
      this.qrCodeSetupImageUrl,
      this.qrCodeSetupKey,
      this.alreadyRegistered,
      this.isEnabled});

  factory Google2FAResponse.fromJson(Map<String, dynamic> json) =>
      _$Google2FAResponseFromJson(json);

  Map<String, dynamic> toJson() => _$Google2FAResponseToJson(this);
}
