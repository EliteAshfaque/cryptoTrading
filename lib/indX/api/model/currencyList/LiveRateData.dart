import 'package:json_annotation/json_annotation.dart';
import 'AllowTransferMapping.dart';
import 'CurrencyToWalletTransferMapping.dart';

part 'LiveRateData.g.dart';

@JsonSerializable()
class LiveRateData {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "walletId")
  int? walletId;
  @JsonKey(name: "opid")
  int? opid;
  @JsonKey(name: "technologyId")
  int? technologyId;
  @JsonKey(name: "currencyId")
  int? currencyId;
  @JsonKey(name: "currencyID")
  int? currencyID;
  @JsonKey(name: "bcmid")
  int? bcmid;
  @JsonKey(name: "walletName")
  String? walletName;
  @JsonKey(name: "businessName")
  String? businessName;
  @JsonKey(name: "currencyName")
  String? currencyName;
  @JsonKey(name: "isBalanceFromDB")
  bool? isBalanceFromDB;
  @JsonKey(name: "balance")
  double? balance;
  @JsonKey(name: "currecySymbol")
  String? currecySymbol;
  @JsonKey(name: "currencySymbol")
  String? currencySymbol;
  @JsonKey(name: "symbol")
  String? symbol;
  @JsonKey(name: "displayConversionCurrSymbol")
  String? displayConversionCurrSymbol;
  @JsonKey(name: "displayConversionCurrImage")
  String? displayConversionCurrImage;
  @JsonKey(name: "displayConversionCurrId")
  int? displayConversionCurrId;
  @JsonKey(name: "isActive")
  bool? isActive;
  @JsonKey(name: "isCoin")
  bool? isCoin;
  @JsonKey(name: "decimalSupport")
  double? decimalSupport;
  @JsonKey(name: "isTransferAllowed")
  bool? isTransferAllowed;
  @JsonKey(name: "isDepositAllowed")
  bool? isDepositAllowed;
  @JsonKey(name: "isDisplayLiveRate")
  bool? isDisplayLiveRate;
  @JsonKey(name: "isAutoDeposit")
  bool? isAutoDeposit;
  @JsonKey(name: "minTransfer")
  double? minTransfer;
  @JsonKey(name: "maxTransfer")
  double? maxTransfer;
  @JsonKey(name: "imageUrls")
  String? imageUrls;
  @JsonKey(name: "isDisplayBalance")
  bool? isDisplayBalance;
  @JsonKey(name: "allowedTransferMappings")
  List<AllowTransferMapping>? allowedTransferMappings;
  @JsonKey(name: "currencyToWalletTransferMappings")
  List<CurrencyToWalletTransferMapping>? currencyToWalletTransferMappings;

  LiveRateData(
      {this.id,
        this.walletId,
        this.opid,
        this.technologyId,
        this.currencyId,
        this.currencyID,
        this.bcmid,
        this.walletName,
        this.businessName,
        this.currencyName,
        this.isBalanceFromDB,
        this.balance,
        this.currecySymbol,
        this.currencySymbol,
        this.symbol,
        this.displayConversionCurrSymbol,
        this.displayConversionCurrImage,
        this.displayConversionCurrId,
        this.isActive,
        this.isCoin,
        this.decimalSupport,
        this.isTransferAllowed,
        this.isDepositAllowed,
        this.isDisplayLiveRate,
        this.isAutoDeposit,
        this.minTransfer,
        this.maxTransfer,
        this.imageUrls,
        this.isDisplayBalance,
        this.allowedTransferMappings,
        this.currencyToWalletTransferMappings});

  factory LiveRateData.fromJson(Map<String, dynamic> json) =>
      _$LiveRateDataFromJson(json);

  Map<String, dynamic> toJson() => _$LiveRateDataToJson(this);
}
