import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';

part 'CurrencyToWalletTransferMapping.g.dart';

@JsonSerializable()
class CurrencyToWalletTransferMapping {

  @JsonKey(name: "fromCurrId")
 
  int? fromCurrId;
  @JsonKey(name: "toWalletId")
 
  int? toWalletId;
  @JsonKey(name: "walletCurrencyId")
 
  int? walletCurrencyId;
  @JsonKey(name: "fromCurrName")
 
  String? fromCurrName;
  @JsonKey(name: "walletCurrencySymbol")
 
  String? walletCurrencySymbol;
  @JsonKey(name: "walletCurrencyName")
 
  String? walletCurrencyName;
  @JsonKey(name: "toWalletName")
 
  String? toWalletName;
  @JsonKey(name: "withdrawlCharges")
 
  double? withdrawlCharges;
  @JsonKey(name: "transferCharges")
 
  double? transferCharges;
  @JsonKey(name: "fromCurrSymbol")
 
  String? fromCurrSymbol;
  @JsonKey(name: "imageUrl")
 
  String? imageUrl;


  CurrencyToWalletTransferMapping(
      {this.fromCurrId,
      this.toWalletId,
      this.walletCurrencyId,
      this.fromCurrName,
      this.walletCurrencySymbol,
      this.walletCurrencyName,
      this.toWalletName,
      this.withdrawlCharges,
      this.transferCharges,
      this.fromCurrSymbol,
      this.imageUrl});

  factory CurrencyToWalletTransferMapping.fromJson(Map<String, dynamic> json) =>
      _$CurrencyToWalletTransferMappingFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyToWalletTransferMappingToJson(this);
}
