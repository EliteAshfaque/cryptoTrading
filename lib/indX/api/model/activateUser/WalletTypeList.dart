import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';

part 'WalletTypeList.g.dart';

@JsonSerializable()
class WalletTypeList  {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "currencyID")
  int? currencyID;
  @JsonKey(name: "currencyName")
  String? currencyName;
  @JsonKey(name: "symbol")
  String? symbol;
  @JsonKey(name: "imageUrl")
  String? imageUrl;
  @JsonKey(name: "displayConversionCurrId")
  int? displayConversionCurrId;
  @JsonKey(name: "displayConversionCurrSymbol")
  String? displayConversionCurrSymbol;
  @JsonKey(name: "displayConversionCurrImage")
  String? displayConversionCurrImage;
  @JsonKey(name: "userBalance")
  double? userBalance;


  WalletTypeList(
      {this.id,
      this.name,
      this.currencyID,
      this.currencyName,
      this.symbol,
      this.imageUrl,
      this.displayConversionCurrId,
      this.displayConversionCurrSymbol,
      this.displayConversionCurrImage,
      this.userBalance});

  factory WalletTypeList.fromJson(Map<String, dynamic> json) =>
      _$WalletTypeListFromJson(json);

  Map<String, dynamic> toJson() => _$WalletTypeListToJson(this);
}
