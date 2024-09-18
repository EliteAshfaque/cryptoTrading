// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CompanyProfileData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyProfileData _$CompanyProfileDataFromJson(Map<String, dynamic> json) =>
    CompanyProfileData(
      name: json['name'] as String?,
      address: json['address'] as String?,
      emailId: json['emailId'] as String?,
      phoneNo: json['phoneNo'] as String?,
      mobileNo: json['mobileNo'] as String?,
      mobileNo2: json['mobileNo2'] as String?,
      accountMobileNo: json['accountMobileNo'] as String?,
      accountEmailId: json['accountEmailId'] as String?,
      accountPhoneNos: json['accountPhoneNos'] as String?,
      accountWhatsAppNos: json['accountWhatsAppNos'] as String?,
      facebook: json['facebook'] as String?,
      instagram: json['instagram'] as String?,
      twitter: json['twitter'] as String?,
      telegram: json['telegram'] as String?,
      telegramBannerUrl: json['telegramBannerUrl'] as String?,
      whatsApp: json['whatsApp'] as String?,
      website: json['website'] as String?,
      headerTitle: json['headerTitle'] as String?,
      customerCareMobileNos: json['customerCareMobileNos'] as String?,
      customerCareEmailIds: json['customerCareEmailIds'] as String?,
      customerPhoneNos: json['customerPhoneNos'] as String?,
      customerWhatsAppNos: json['customerWhatsAppNos'] as String?,
      salesPersonNo: json['salesPersonNo'] as String?,
      salesPersonEmail: json['salesPersonEmail'] as String?,
      appName: json['appName'] as String?,
      ownerName: json['ownerName'] as String?,
      ownerDesignation: json['ownerDesignation'] as String?,
      kycStatus: (json['kycStatus'] as num?)?.toInt(),
      signupReferalID: (json['signupReferalID'] as num?)?.toInt(),
      pan: json['pan'] as String?,
      userAddress: json['userAddress'] as String?,
      isOutletRequired: json['isOutletRequired'] as bool?,
    );

Map<String, dynamic> _$CompanyProfileDataToJson(CompanyProfileData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'emailId': instance.emailId,
      'phoneNo': instance.phoneNo,
      'mobileNo': instance.mobileNo,
      'mobileNo2': instance.mobileNo2,
      'accountMobileNo': instance.accountMobileNo,
      'accountEmailId': instance.accountEmailId,
      'accountPhoneNos': instance.accountPhoneNos,
      'accountWhatsAppNos': instance.accountWhatsAppNos,
      'facebook': instance.facebook,
      'instagram': instance.instagram,
      'twitter': instance.twitter,
      'telegram': instance.telegram,
      'telegramBannerUrl': instance.telegramBannerUrl,
      'whatsApp': instance.whatsApp,
      'website': instance.website,
      'headerTitle': instance.headerTitle,
      'customerCareMobileNos': instance.customerCareMobileNos,
      'customerCareEmailIds': instance.customerCareEmailIds,
      'customerPhoneNos': instance.customerPhoneNos,
      'customerWhatsAppNos': instance.customerWhatsAppNos,
      'salesPersonNo': instance.salesPersonNo,
      'salesPersonEmail': instance.salesPersonEmail,
      'appName': instance.appName,
      'ownerName': instance.ownerName,
      'ownerDesignation': instance.ownerDesignation,
      'kycStatus': instance.kycStatus,
      'signupReferalID': instance.signupReferalID,
      'pan': instance.pan,
      'userAddress': instance.userAddress,
      'isOutletRequired': instance.isOutletRequired,
    };
