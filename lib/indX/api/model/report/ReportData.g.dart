// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ReportData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportData _$ReportDataFromJson(Map<String, dynamic> json) => ReportData(
      oid: (json['oid'] as num?)?.toInt(),
      levelNo: (json['levelNo'] as num?)?.toInt(),
      referalID: (json['referalID'] as num?)?.toInt(),
      packageAmount: (json['packageAmount'] as num?)?.toDouble(),
      amount: (json['amount'] as num?)?.toDouble(),
      packageCost: (json['packageCost'] as num?)?.toDouble(),
      selfBussiness: (json['selfBussiness'] as num?)?.toDouble(),
      teamBussiness: (json['teamBussiness'] as num?)?.toDouble(),
      directBusiness: (json['directBusiness'] as num?)?.toDouble(),
      introducedBy: (json['introducedBy'] as num?)?.toInt(),
      businessTypeId: json['businessTypeId'] as String?,
      businessType: json['businessType'] as String?,
      businessDate: json['businessDate'] as String?,
      businessCurrency: json['businessCurrency'] as String?,
      entryDate: json['entryDate'] as String?,
      activationDate: json['activationDate'] as String?,
      status: json['status'] as String?,
      regDate: json['regDate'] as String?,
      registerDate: json['registerDate'] as String?,
      mobileNo: json['mobileNo'] as String?,
      name: json['name'] as String?,
      userName: json['userName'] as String?,
      username: json['username'] as String?,
      emailID: json['emailID'] as String?,
      strUserId: json['strUserId'] as String?,
      userID: (json['userID'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      parentId: (json['parentId'] as num?)?.toInt(),
      parentName: json['parentName'] as String?,
      sponserId: json['sponserId'] as String?,
      sponserName: json['sponserName'] as String?,
      position: json['position'] as String?,
      leg: json['leg'] as String?,
      legs: json['legs'] as String?,
    );

Map<String, dynamic> _$ReportDataToJson(ReportData instance) =>
    <String, dynamic>{
      'oid': instance.oid,
      'levelNo': instance.levelNo,
      'referalID': instance.referalID,
      'packageAmount': instance.packageAmount,
      'amount': instance.amount,
      'packageCost': instance.packageCost,
      'selfBussiness': instance.selfBussiness,
      'teamBussiness': instance.teamBussiness,
      'directBusiness': instance.directBusiness,
      'introducedBy': instance.introducedBy,
      'businessTypeId': instance.businessTypeId,
      'businessType': instance.businessType,
      'businessDate': instance.businessDate,
      'businessCurrency': instance.businessCurrency,
      'entryDate': instance.entryDate,
      'activationDate': instance.activationDate,
      'status': instance.status,
      'regDate': instance.regDate,
      'registerDate': instance.registerDate,
      'mobileNo': instance.mobileNo,
      'name': instance.name,
      'userName': instance.userName,
      'username': instance.username,
      'emailID': instance.emailID,
      'strUserId': instance.strUserId,
      'userID': instance.userID,
      'userId': instance.userId,
      'parentId': instance.parentId,
      'parentName': instance.parentName,
      'sponserId': instance.sponserId,
      'sponserName': instance.sponserName,
      'position': instance.position,
      'leg': instance.leg,
      'legs': instance.legs,
    };
