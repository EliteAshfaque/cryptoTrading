import 'package:json_annotation/json_annotation.dart';

part 'AllowedWallet.g.dart';

@JsonSerializable()
class AllowedWallet {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "fromWallet")
  int? fromWallet;
  @JsonKey(name: "fromWalletId")
  int? fromWalletId;
  @JsonKey(name: "toWalletId")
  int? toWalletId;
  @JsonKey(name: "isActive")
  bool? isActive;
  @JsonKey(name: "toWalletName")
  String? toWalletName;
  @JsonKey(name: "fromWalletName")
  String? fromWalletName;
  @JsonKey(name: "walletName")
  String? walletName;


  AllowedWallet(
      {this.id,
      this.fromWallet,
      this.fromWalletId,
      this.toWalletId,
      this.isActive,
      this.toWalletName,
      this.fromWalletName,
      this.walletName});

  factory AllowedWallet.fromJson(Map<String, dynamic> json) =>
      _$AllowedWalletFromJson(json);

  Map<String, dynamic> toJson() => _$AllowedWalletToJson(this);
}
