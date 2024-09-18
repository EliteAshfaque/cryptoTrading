// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EditUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditUser _$EditUserFromJson(Map<String, dynamic> json) => EditUser(
      profilePic: json['profilePic'] as String?,
      branchName: json['branchName'] as String?,
      commRate: (json['commRate'] as num?)?.toDouble(),
      aadhar: json['aadhar'] as String?,
      pan: json['pan'] as String?,
      gstin: json['gstin'] as String?,
      address: json['address'] as String?,
      userID: (json['userID'] as num?)?.toInt(),
      mobileNo: json['mobileNo'] as String?,
      name: json['name'] as String?,
      outletName: json['outletName'] as String?,
      emailID: json['emailID'] as String?,
      isGSTApplicable: json['isGSTApplicable'] as bool?,
      isTDSApplicable: json['isTDSApplicable'] as bool?,
      isCCFGstApplicable: json['isCCFGstApplicable'] as bool?,
      pincode: json['pincode'] as String?,
      dob: json['dob'] as String?,
      shopType: json['shopType'] as String?,
      qualification: json['qualification'] as String?,
      poupulation: json['poupulation'] as String?,
      locationType: json['locationType'] as String?,
      landmark: json['landmark'] as String?,
      alternateMobile: json['alternateMobile'] as String?,
      bankName: json['bankName'] as String?,
      ifsc: json['ifsc'] as String?,
      accountNumber: json['accountNumber'] as String?,
      accountName: json['accountName'] as String?,
    );

Map<String, dynamic> _$EditUserToJson(EditUser instance) => <String, dynamic>{
      'profilePic': instance.profilePic,
      'branchName': instance.branchName,
      'commRate': instance.commRate,
      'aadhar': instance.aadhar,
      'pan': instance.pan,
      'gstin': instance.gstin,
      'address': instance.address,
      'userID': instance.userID,
      'mobileNo': instance.mobileNo,
      'name': instance.name,
      'outletName': instance.outletName,
      'emailID': instance.emailID,
      'isGSTApplicable': instance.isGSTApplicable,
      'isTDSApplicable': instance.isTDSApplicable,
      'isCCFGstApplicable': instance.isCCFGstApplicable,
      'pincode': instance.pincode,
      'dob': instance.dob,
      'shopType': instance.shopType,
      'qualification': instance.qualification,
      'poupulation': instance.poupulation,
      'locationType': instance.locationType,
      'landmark': instance.landmark,
      'alternateMobile': instance.alternateMobile,
      'bankName': instance.bankName,
      'ifsc': instance.ifsc,
      'accountNumber': instance.accountNumber,
      'accountName': instance.accountName,
    };
