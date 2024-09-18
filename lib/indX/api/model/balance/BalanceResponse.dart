import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'BalanceData.dart';

part 'BalanceResponse.g.dart';

@JsonSerializable()
class BalanceResponse extends BasicResponse {
  @JsonKey(name: "fiatCurrencyId")
  int? fiatCurrencyId;
  @JsonKey(name: "defaultCurrencyId")
  int? defaultCurrencyId;
  @JsonKey(name: "defaultCurrencyName")
  String? defaultCurrencyName;
  @JsonKey(name: "defaultCurrencySymbol")
  String? defaultCurrencySymbol;
  @JsonKey(name: "externalAddress")
  String? externalAddress;
  @JsonKey(name: "isP")
  bool? isP;
  @JsonKey(name: "isPN")
  bool? isPN;
  @JsonKey(name: "isLowBalance")
  bool? isLowBalance;
  @JsonKey(name: "isPackageDeducionForRetailor")
  bool? isPackageDeducionForRetailor;
  @JsonKey(name: "isQRMappedToUser")
  bool? isQRMappedToUser;
  @JsonKey(name: "isCandebit")
  bool? isCandebit;
  @JsonKey(name: "isUPI")
  bool? isUPI;
  @JsonKey(name: "isSwaped")
  bool? isSwaped;
  @JsonKey(name: "isStake")
  bool? isStake;
  @JsonKey(name: "isUPIPayment")
  bool? isUPIPayment;
  @JsonKey(name: "isBidWithPG")
  bool? isBidWithPG;
  @JsonKey(name: "isBinaryon")
  int? isBinaryon;
  @JsonKey(name: "isLevelIncome")
  bool? isLevelIncome;
  @JsonKey(name: "isEKYCForced")
  bool? isEKYCForced;
  @JsonKey(name: "isDrawOpImage")
  bool? isDrawOpImage;
  @JsonKey(name: "userTopupType")
  int? userTopupType;
  @JsonKey(name: "userTopupBy")
  int? userTopupBy;
  @JsonKey(name: "isUPIQR")
  bool? isUPIQR;
  @JsonKey(name: "isECollectEnable")
  bool? isECollectEnable;
  @JsonKey(name: "isAddMoneyEnable")
  bool? isAddMoneyEnable;
  @JsonKey(name: "isReTopupAllow")
  bool? isReTopupAllow;
  @JsonKey(name: "isFlatCommission")
  bool? isFlatCommission;
  @JsonKey(name: "isTopupByPackage")
  bool? isTopupByPackage;
  @JsonKey(name: "isTopupByEpin")
  bool? isTopupByEpin;
  @JsonKey(name: "isTopup")
  int? isTopup;
  @JsonKey(name: "isGoogle2FAEnable")
  bool? isGoogle2FAEnable;
  @JsonKey(name: "isGoogle2FARegister")
  bool? isGoogle2FARegister;
  @JsonKey(name: "isEmailVerified")
  bool? isEmailVerified;
  @JsonKey(name: "isMobileVerified")
  bool? isMobileVerified;
  @JsonKey(name: "isRenewalRequired")
  bool? isRenewalRequired;
  @JsonKey(name: "isLoterryModule")
  bool? isLoterryModule;
  @JsonKey(name: "balanceData")
  List<BalanceData>? balanceData;

  BalanceResponse(
      {this.fiatCurrencyId,
      this.defaultCurrencyId,
      this.defaultCurrencyName,
      this.defaultCurrencySymbol,
      this.externalAddress,
      this.isP,
      this.isPN,
      this.isLowBalance,
      this.isPackageDeducionForRetailor,
      this.isQRMappedToUser,
      this.isCandebit,
      this.isUPI,
      this.isSwaped,
      this.isStake,
      this.isUPIPayment,
      this.isBidWithPG,
      this.isBinaryon,
      this.isLevelIncome,
      this.isEKYCForced,
      this.isDrawOpImage,
      this.userTopupType,
      this.userTopupBy,
      this.isUPIQR,
      this.isECollectEnable,
      this.isAddMoneyEnable,
      this.isReTopupAllow,
      this.isFlatCommission,
      this.isTopupByPackage,
      this.isTopupByEpin,
      this.isTopup,
      this.isGoogle2FAEnable,
      this.isGoogle2FARegister,
      this.isEmailVerified,
      this.isMobileVerified,
      this.isRenewalRequired,
      this.isLoterryModule,
      this.balanceData});

  factory BalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$BalanceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceResponseToJson(this);
}
