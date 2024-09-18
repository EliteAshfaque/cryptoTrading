// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ActivateUserResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivateUserResponse _$ActivateUserResponseFromJson(
        Map<String, dynamic> json) =>
    ActivateUserResponse(
      txnHash: json['txnHash'] as String?,
      fromAddress: json['fromAddress'] as String?,
      toAddress: json['toAddress'] as String?,
      requestAmount: json['requestAmount'] as String?,
      transactionAmount: (json['transactionAmount'] as num?)?.toDouble(),
      amountinToWalletCurrency:
          (json['amountinToWalletCurrency'] as num?)?.toDouble(),
      toCurrencyName: json['toCurrencyName'] as String?,
      requestCurrecny: json['requestCurrecny'] as String?,
      stakeAmount: json['stakeAmount'] as String?,
      tid: (json['tid'] as num?)?.toInt(),
      lockingPeriod: json['lockingPeriod'] as String?,
      monthlyMinting: json['monthlyMinting'] as String?,
      status: (json['status'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      topupCurrID: (json['topupCurrID'] as num?)?.toInt(),
      topupDate: json['topupDate'] as String?,
      topUpAmount: (json['topUpAmount'] as num?)?.toDouble(),
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

Map<String, dynamic> _$ActivateUserResponseToJson(
        ActivateUserResponse instance) =>
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
      'txnHash': instance.txnHash,
      'fromAddress': instance.fromAddress,
      'toAddress': instance.toAddress,
      'requestAmount': instance.requestAmount,
      'transactionAmount': instance.transactionAmount,
      'amountinToWalletCurrency': instance.amountinToWalletCurrency,
      'toCurrencyName': instance.toCurrencyName,
      'requestCurrecny': instance.requestCurrecny,
      'stakeAmount': instance.stakeAmount,
      'tid': instance.tid,
      'lockingPeriod': instance.lockingPeriod,
      'monthlyMinting': instance.monthlyMinting,
      'status': instance.status,
      'id': instance.id,
      'topupCurrID': instance.topupCurrID,
      'topupDate': instance.topupDate,
      'topUpAmount': instance.topUpAmount,
    };
