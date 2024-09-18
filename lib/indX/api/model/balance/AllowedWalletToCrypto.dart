import 'package:json_annotation/json_annotation.dart';

part 'AllowedWalletToCrypto.g.dart';

@JsonSerializable()
class AllowedWalletToCrypto {
  @JsonKey(name: "symbolId")
  int? symbolId;
  @JsonKey(name: "walletId")
  int? walletId;
  @JsonKey(name: "isActive")
  bool? isActive;
  @JsonKey(name: "symbolName")
  String? symbolName;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "isdoubbleFactor")
  bool? isdoubbleFactor;
  @JsonKey(name: "isExternalAddress")
  bool? isExternalAddress;

  AllowedWalletToCrypto(
      {this.symbolId,
      this.walletId,
      this.isActive,
      this.symbolName,
      this.image,
      this.isdoubbleFactor,
      this.isExternalAddress});

  factory AllowedWalletToCrypto.fromJson(Map<String, dynamic> json) =>
      _$AllowedWalletToCryptoFromJson(json);

  Map<String, dynamic> toJson() => _$AllowedWalletToCryptoToJson(this);
}
