import 'package:json_annotation/json_annotation.dart';

import 'AllowedWallet.dart';
import 'AllowedWalletToCrypto.dart';
import 'AllowedWithdrawalType.dart';

part 'BalanceData.g.dart';

@JsonSerializable()
class BalanceData {
  @JsonKey(name: "walletCurrencyID")
  int? walletCurrencyID;
  @JsonKey(name: "walletCurrencyName")
  String? walletCurrencyName;
  @JsonKey(name: "walletCurrencySymbol")
  String? walletCurrencySymbol;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "walletType")
  String? walletType;
  @JsonKey(name: "inFundProcess")
  bool? inFundProcess;
  @JsonKey(name: "preferredForShoping")
  int? preferredForShoping;
  @JsonKey(name: "deductionPercent")
  double? deductionPercent;
  @JsonKey(name: "isPackageDedectionForRetailor")
  bool? isPackageDedectionForRetailor;
  @JsonKey(name: "minTransferAmount")
  double? minTransferAmount;
  @JsonKey(name: "maxTransferAmount")
  double? maxTransferAmount;
  @JsonKey(name: "maxTransaferCount")
  double? maxTransaferCount;
  @JsonKey(name: "minWithdrawalAmount")
  double? minWithdrawalAmount;
  @JsonKey(name: "maxWithdrawalAmount")
  double? maxWithdrawalAmount;
  @JsonKey(name: "maxWithdrawalCount")
  double? maxWithdrawalCount;
  @JsonKey(name: "walletTransferType")
  int? walletTransferType; /*1 Self Only==>Transfer himself    2 Downline Only==>Transfer towords downline team    3 Both==>Self and Downline  4 Both All==>Self and all  5 Others Only==>All others members*/
  @JsonKey(name: "withdrawalType")
  int? withdrawalType;
  @JsonKey(name: "isWithdrawal")
  bool? isWithdrawal;
  @JsonKey(name: "balance")
  double? balance;
  @JsonKey(name: "capping")
  double? capping;
  @JsonKey(name: "allowedWallet")
  List<AllowedWallet>? allowedWallet;
  @JsonKey(name: "allowedWithdrawalType")
  List<AllowedWithdrawalType>? allowedWithdrawalType;
  @JsonKey(name: "allowedWalletToCripto")
  List<AllowedWalletToCrypto>? allowedWalletToCripto;

  /* String getWalletCurrencySymbol() {

    if (walletCurrencySymbol != null && walletCurrencySymbol!.isNotEmpty) {
      if (walletCurrencySymbol!.toLowerCase()=="usdt"
          || walletCurrencySymbol!.toLowerCase()=="usd") {
        return "\$";
      } else if (walletCurrencySymbol!.toLowerCase()=="inr"
          || walletCurrencySymbol!.toLowerCase()=="rupee") {
        return "\u20B9";
      } else {
        return walletCurrencySymbol??"\u20B9";
      }
    }
    return walletCurrencySymbol??"\u20B9";
  }*/

  BalanceData(
      {this.walletCurrencyID,
      this.walletCurrencyName,
      this.walletCurrencySymbol,
      this.id,
      this.walletType,
      this.inFundProcess,
      this.preferredForShoping,
      this.deductionPercent,
      this.isPackageDedectionForRetailor,
      this.minTransferAmount,
      this.maxTransferAmount,
      this.maxTransaferCount,
      this.minWithdrawalAmount,
      this.maxWithdrawalAmount,
      this.maxWithdrawalCount,
      this.walletTransferType,
      this.withdrawalType,
      this.isWithdrawal,
      this.balance,
      this.capping,
      this.allowedWallet,
      this.allowedWithdrawalType,
      this.allowedWalletToCripto});

  factory BalanceData.fromJson(Map<String, dynamic> json) =>
      _$BalanceDataFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceDataToJson(this);
}
