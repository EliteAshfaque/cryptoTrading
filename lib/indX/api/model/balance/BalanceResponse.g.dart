// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BalanceResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceResponse _$BalanceResponseFromJson(Map<String, dynamic> json) =>
    BalanceResponse(
      fiatCurrencyId: (json['fiatCurrencyId'] as num?)?.toInt(),
      defaultCurrencyId: (json['defaultCurrencyId'] as num?)?.toInt(),
      defaultCurrencyName: json['defaultCurrencyName'] as String?,
      defaultCurrencySymbol: json['defaultCurrencySymbol'] as String?,
      externalAddress: json['externalAddress'] as String?,
      isP: json['isP'] as bool?,
      isPN: json['isPN'] as bool?,
      isLowBalance: json['isLowBalance'] as bool?,
      isPackageDeducionForRetailor:
          json['isPackageDeducionForRetailor'] as bool?,
      isQRMappedToUser: json['isQRMappedToUser'] as bool?,
      isCandebit: json['isCandebit'] as bool?,
      isUPI: json['isUPI'] as bool?,
      isSwaped: json['isSwaped'] as bool?,
      isStake: json['isStake'] as bool?,
      isUPIPayment: json['isUPIPayment'] as bool?,
      isBidWithPG: json['isBidWithPG'] as bool?,
      isBinaryon: (json['isBinaryon'] as num?)?.toInt(),
      isLevelIncome: json['isLevelIncome'] as bool?,
      isEKYCForced: json['isEKYCForced'] as bool?,
      isDrawOpImage: json['isDrawOpImage'] as bool?,
      userTopupType: (json['userTopupType'] as num?)?.toInt(),
      userTopupBy: (json['userTopupBy'] as num?)?.toInt(),
      isUPIQR: json['isUPIQR'] as bool?,
      isECollectEnable: json['isECollectEnable'] as bool?,
      isAddMoneyEnable: json['isAddMoneyEnable'] as bool?,
      isReTopupAllow: json['isReTopupAllow'] as bool?,
      isFlatCommission: json['isFlatCommission'] as bool?,
      isTopupByPackage: json['isTopupByPackage'] as bool?,
      isTopupByEpin: json['isTopupByEpin'] as bool?,
      isTopup: (json['isTopup'] as num?)?.toInt(),
      isGoogle2FAEnable: json['isGoogle2FAEnable'] as bool?,
      isGoogle2FARegister: json['isGoogle2FARegister'] as bool?,
      isEmailVerified: json['isEmailVerified'] as bool?,
      isMobileVerified: json['isMobileVerified'] as bool?,
      isRenewalRequired: json['isRenewalRequired'] as bool?,
      isLoterryModule: json['isLoterryModule'] as bool?,
      balanceData: (json['balanceData'] as List<dynamic>?)
          ?.map((e) => BalanceData.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..refID = json['refID'] as String?
      ..referenceID = (json['referenceID'] as num?)?.toInt()
      ..isReferral = json['isReferral'] as bool?
      ..isHeavyRefresh = json['isHeavyRefresh'] as bool?
      ..isTargetShow = json['isTargetShow'] as bool?
      ..isRealAPIPerTransaction = json['isRealAPIPerTransaction'] as bool?
      ..isAdminFlatComm = json['isAdminFlatComm'] as bool?
      ..activeFlatType = (json['activeFlatType'] as num?)?.toInt()
      ..isDenominationIncentive = json['isDenominationIncentive'] as bool?
      ..isAutoBilling = json['isAutoBilling'] as bool?
      ..withCustomLoginID = json['withCustomLoginID'] as bool?
      ..isVirtualAccountInternal = json['isVirtualAccountInternal'] as bool?
      ..isAccountStatement = json['isAccountStatement'] as bool?
      ..isAreaMaster = json['isAreaMaster'] as bool?
      ..isPlanServiceUpdated = json['isPlanServiceUpdated'] as bool?
      ..dashPreferenceApp = (json['dashPreferenceApp'] as num?)?.toInt()
      ..isFintechServiceOn = json['isFintechServiceOn'] as bool?
      ..isMLM = json['isMLM'] as bool?
      ..isECommerceAllowed = json['isECommerceAllowed'] as bool?
      ..statuscode = (json['statuscode'] as num?)?.toInt()
      ..msg = json['msg'] as String?
      ..isVersionValid = json['isVersionValid'] as bool?
      ..isAppValid = json['isAppValid'] as bool?
      ..checkID = (json['checkID'] as num?)?.toInt()
      ..isPasswordExpired = json['isPasswordExpired'] as bool?
      ..name = json['name'] as String?
      ..mobileNo = json['mobileNo'] as String?
      ..emailID = json['emailID'] as String?
      ..otpSession = json['otpSession'] as String?
      ..isLookUpFromAPI = json['isLookUpFromAPI'] as bool?
      ..isDTHInfoCall = json['isDTHInfoCall'] as bool?
      ..isShowPDFPlan = json['isShowPDFPlan'] as bool?
      ..isOTPRequired = json['isOTPRequired'] as bool?
      ..isResendAvailable = json['isResendAvailable'] as bool?
      ..isDTHInfo = json['isDTHInfo'] as bool?
      ..isRoffer = json['isRoffer'] as bool?
      ..isGreen = json['isGreen'] as bool?
      ..isBulkQRGeneration = json['isBulkQRGeneration'] as bool?
      ..isCoin = json['isCoin'] as bool?
      ..legs = json['legs'] as String?
      ..userId = json['userId']
      ..loginUrl = json['loginUrl'] as String?
      ..userName = json['userName'] as String?
      ..password = json['password'] as String?
      ..isSattlemntAccountVerify = json['isSattlemntAccountVerify'] as bool?
      ..fiatCurrID = (json['fiatCurrID'] as num?)?.toInt()
      ..fiatCurrSymbol = json['fiatCurrSymbol'] as String?
      ..fiatCurrName = json['fiatCurrName'] as String?
      ..fiatTechnologyId = (json['fiatTechnologyId'] as num?)?.toInt()
      ..fiatImageUrl = json['fiatImageUrl'] as String?;

Map<String, dynamic> _$BalanceResponseToJson(BalanceResponse instance) =>
    <String, dynamic>{
      'refID': instance.refID,
      'referenceID': instance.referenceID,
      'isReferral': instance.isReferral,
      'isHeavyRefresh': instance.isHeavyRefresh,
      'isTargetShow': instance.isTargetShow,
      'isRealAPIPerTransaction': instance.isRealAPIPerTransaction,
      'isAdminFlatComm': instance.isAdminFlatComm,
      'activeFlatType': instance.activeFlatType,
      'isDenominationIncentive': instance.isDenominationIncentive,
      'isAutoBilling': instance.isAutoBilling,
      'withCustomLoginID': instance.withCustomLoginID,
      'isVirtualAccountInternal': instance.isVirtualAccountInternal,
      'isAccountStatement': instance.isAccountStatement,
      'isAreaMaster': instance.isAreaMaster,
      'isPlanServiceUpdated': instance.isPlanServiceUpdated,
      'dashPreferenceApp': instance.dashPreferenceApp,
      'isFintechServiceOn': instance.isFintechServiceOn,
      'isMLM': instance.isMLM,
      'isECommerceAllowed': instance.isECommerceAllowed,
      'statuscode': instance.statuscode,
      'msg': instance.msg,
      'isVersionValid': instance.isVersionValid,
      'isAppValid': instance.isAppValid,
      'checkID': instance.checkID,
      'isPasswordExpired': instance.isPasswordExpired,
      'name': instance.name,
      'mobileNo': instance.mobileNo,
      'emailID': instance.emailID,
      'otpSession': instance.otpSession,
      'isLookUpFromAPI': instance.isLookUpFromAPI,
      'isDTHInfoCall': instance.isDTHInfoCall,
      'isShowPDFPlan': instance.isShowPDFPlan,
      'isOTPRequired': instance.isOTPRequired,
      'isResendAvailable': instance.isResendAvailable,
      'isDTHInfo': instance.isDTHInfo,
      'isRoffer': instance.isRoffer,
      'isGreen': instance.isGreen,
      'isBulkQRGeneration': instance.isBulkQRGeneration,
      'isCoin': instance.isCoin,
      'legs': instance.legs,
      'userId': instance.userId,
      'loginUrl': instance.loginUrl,
      'userName': instance.userName,
      'password': instance.password,
      'isSattlemntAccountVerify': instance.isSattlemntAccountVerify,
      'fiatCurrID': instance.fiatCurrID,
      'fiatCurrSymbol': instance.fiatCurrSymbol,
      'fiatCurrName': instance.fiatCurrName,
      'fiatTechnologyId': instance.fiatTechnologyId,
      'fiatImageUrl': instance.fiatImageUrl,
      'fiatCurrencyId': instance.fiatCurrencyId,
      'defaultCurrencyId': instance.defaultCurrencyId,
      'defaultCurrencyName': instance.defaultCurrencyName,
      'defaultCurrencySymbol': instance.defaultCurrencySymbol,
      'externalAddress': instance.externalAddress,
      'isP': instance.isP,
      'isPN': instance.isPN,
      'isLowBalance': instance.isLowBalance,
      'isPackageDeducionForRetailor': instance.isPackageDeducionForRetailor,
      'isQRMappedToUser': instance.isQRMappedToUser,
      'isCandebit': instance.isCandebit,
      'isUPI': instance.isUPI,
      'isSwaped': instance.isSwaped,
      'isStake': instance.isStake,
      'isUPIPayment': instance.isUPIPayment,
      'isBidWithPG': instance.isBidWithPG,
      'isBinaryon': instance.isBinaryon,
      'isLevelIncome': instance.isLevelIncome,
      'isEKYCForced': instance.isEKYCForced,
      'isDrawOpImage': instance.isDrawOpImage,
      'userTopupType': instance.userTopupType,
      'userTopupBy': instance.userTopupBy,
      'isUPIQR': instance.isUPIQR,
      'isECollectEnable': instance.isECollectEnable,
      'isAddMoneyEnable': instance.isAddMoneyEnable,
      'isReTopupAllow': instance.isReTopupAllow,
      'isFlatCommission': instance.isFlatCommission,
      'isTopupByPackage': instance.isTopupByPackage,
      'isTopupByEpin': instance.isTopupByEpin,
      'isTopup': instance.isTopup,
      'isGoogle2FAEnable': instance.isGoogle2FAEnable,
      'isGoogle2FARegister': instance.isGoogle2FARegister,
      'isEmailVerified': instance.isEmailVerified,
      'isMobileVerified': instance.isMobileVerified,
      'isRenewalRequired': instance.isRenewalRequired,
      'isLoterryModule': instance.isLoterryModule,
      'balanceData': instance.balanceData,
    };
