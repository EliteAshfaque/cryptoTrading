// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FundRequestRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FundRequestRequest _$FundRequestRequestFromJson(Map<String, dynamic> json) =>
    FundRequestRequest(
      json['orderID'] as String?,
      json['upiid'] as String?,
      json['checksum'] as String?,
      (json['bankID'] as num?)?.toInt(),
      json['amount'] as String?,
      json['transactionID'] as String?,
      json['mobileNo'] as String?,
      json['chequeNo'] as String?,
      json['cardNo'] as String?,
      json['accountHolderName'] as String?,
      json['accountNumber'] as String?,
      (json['isImage'] as num?)?.toInt(),
      (json['paymentID'] as num?)?.toInt(),
      (json['walletTypeID'] as num?)?.toInt(),
      (json['loginTypeID'] as num?)?.toInt(),
      (json['userID'] as num?)?.toInt(),
      json['session'] as String?,
      (json['sessionID'] as num?)?.toInt(),
      json['appid'] as String?,
      json['imei'] as String?,
      json['regKey'] as String?,
      json['version'] as String?,
      json['serialNo'] as String?,
    )..isSeller = json['isSeller'] as bool?;

Map<String, dynamic> _$FundRequestRequestToJson(FundRequestRequest instance) =>
    <String, dynamic>{
      'loginTypeID': instance.loginTypeID,
      'userID': instance.userID,
      'session': instance.session,
      'sessionID': instance.sessionID,
      'appid': instance.appid,
      'imei': instance.imei,
      'regKey': instance.regKey,
      'version': instance.version,
      'serialNo': instance.serialNo,
      'isSeller': instance.isSeller,
      'orderID': instance.orderID,
      'upiid': instance.upiid,
      'checksum': instance.checksum,
      'bankID': instance.bankID,
      'amount': instance.amount,
      'transactionID': instance.transactionID,
      'mobileNo': instance.mobileNo,
      'chequeNo': instance.chequeNo,
      'cardNo': instance.cardNo,
      'accountHolderName': instance.accountHolderName,
      'accountNumber': instance.accountNumber,
      'isImage': instance.isImage,
      'paymentID': instance.paymentID,
      'walletTypeID': instance.walletTypeID,
    };
