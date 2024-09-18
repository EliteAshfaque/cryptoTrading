import 'package:json_annotation/json_annotation.dart';

part 'ActivateUserRequest.g.dart';

@JsonSerializable()
class ActivateUserRequest {
  @JsonKey(name: "WalletId")
  int? WalletId;
  @JsonKey(name: "TopupUserId")
  String? TopupUserId;
  @JsonKey(name: "PackageID")
  int? PackageID;
  @JsonKey(name: "BusinessType")
  int? BusinessType;
  @JsonKey(name: "EPin")
  String? EPin;
  @JsonKey(name: "PackageAmount")
  String? PackageAmount;
  @JsonKey(name: "FromCurrencyId")
  int? FromCurrencyId;


  ActivateUserRequest(this.WalletId, this.TopupUserId, this.PackageID,
      this.BusinessType, this.EPin, this.PackageAmount, this.FromCurrencyId);

  factory ActivateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$ActivateUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ActivateUserRequestToJson(this);
}
