// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BankAccountsData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankAccountsData _$BankAccountsDataFromJson(Map<String, dynamic> json) =>
    BankAccountsData(
      id: (json['id'] as num?)?.toInt(),
      bankID: (json['bankID'] as num?)?.toInt(),
      bankName: json['bankName'] as String?,
      ifsc: json['ifsc'] as String?,
      accountNumber: json['accountNumber'] as String?,
      accountHolder: json['accountHolder'] as String?,
      entryBy: (json['entryBy'] as num?)?.toInt(),
      entryDate: json['entryDate'] as String?,
      approvedBY: json['approvedBY'] as String?,
      approvalIp: json['approvalIp'] as String?,
      approvalDate: json['approvalDate'] as String?,
      actualname: json['actualname'] as String?,
      utr: json['utr'] as String?,
      apiid: json['apiid'] as String?,
      approvalStatus: (json['approvalStatus'] as num?)?.toInt(),
      verificationStatus: (json['verificationStatus'] as num?)?.toInt(),
      isdeleted: json['isdeleted'] as String?,
      isDefault: json['isDefault'] as bool?,
      verificationText: json['verificationText'] as String?,
      approvalText: json['approvalText'] as String?,
      bankselect: json['bankselect'] as String?,
      requestdate: json['requestdate'] as String?,
      mobileNo: json['mobileNo'] as String?,
      name: json['name'] as String?,
      requestID: (json['requestID'] as num?)?.toInt(),
      loginID: (json['loginID'] as num?)?.toInt(),
      loginTypeID: (json['loginTypeID'] as num?)?.toInt(),
      userID: (json['userID'] as num?)?.toInt(),
      commonInt: (json['commonInt'] as num?)?.toInt(),
      commonInt2: (json['commonInt2'] as num?)?.toInt(),
      commonStr: json['commonStr'] as String?,
      commonStr2: json['commonStr2'] as String?,
      isListType: json['isListType'] as bool?,
      str: json['str'] as String?,
      commonInt3: (json['commonInt3'] as num?)?.toInt(),
      commonDecimal: (json['commonDecimal'] as num?)?.toDouble(),
      commonInt4: (json['commonInt4'] as num?)?.toInt(),
      commonStr3: json['commonStr3'] as String?,
      commonStr4: json['commonStr4'] as String?,
      commonBool: json['commonBool'] as bool?,
      commonBool1: json['commonBool1'] as bool?,
      commonBool2: json['commonBool2'] as bool?,
      commonChar: json['commonChar'] as String?,
    );

Map<String, dynamic> _$BankAccountsDataToJson(BankAccountsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bankID': instance.bankID,
      'bankName': instance.bankName,
      'ifsc': instance.ifsc,
      'accountNumber': instance.accountNumber,
      'accountHolder': instance.accountHolder,
      'entryBy': instance.entryBy,
      'entryDate': instance.entryDate,
      'approvedBY': instance.approvedBY,
      'approvalIp': instance.approvalIp,
      'approvalDate': instance.approvalDate,
      'actualname': instance.actualname,
      'utr': instance.utr,
      'apiid': instance.apiid,
      'approvalStatus': instance.approvalStatus,
      'verificationStatus': instance.verificationStatus,
      'isdeleted': instance.isdeleted,
      'isDefault': instance.isDefault,
      'verificationText': instance.verificationText,
      'approvalText': instance.approvalText,
      'bankselect': instance.bankselect,
      'requestdate': instance.requestdate,
      'mobileNo': instance.mobileNo,
      'name': instance.name,
      'requestID': instance.requestID,
      'loginID': instance.loginID,
      'loginTypeID': instance.loginTypeID,
      'userID': instance.userID,
      'commonInt': instance.commonInt,
      'commonInt2': instance.commonInt2,
      'commonStr': instance.commonStr,
      'commonStr2': instance.commonStr2,
      'isListType': instance.isListType,
      'str': instance.str,
      'commonInt3': instance.commonInt3,
      'commonDecimal': instance.commonDecimal,
      'commonInt4': instance.commonInt4,
      'commonStr3': instance.commonStr3,
      'commonStr4': instance.commonStr4,
      'commonBool': instance.commonBool,
      'commonBool1': instance.commonBool1,
      'commonBool2': instance.commonBool2,
      'commonChar': instance.commonChar,
    };