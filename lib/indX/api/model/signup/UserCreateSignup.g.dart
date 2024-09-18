// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserCreateSignup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCreateSignup _$UserCreateSignupFromJson(Map<String, dynamic> json) =>
    UserCreateSignup(
      referalID: json['referalID'] as String?,
      referalIDstr: json['referalIDstr'] as String?,
      address: json['address'] as String?,
      mobileNo: json['mobileNo'] as String?,
      name: json['name'] as String?,
      outletName: json['outletName'] as String?,
      roleID: (json['roleID'] as num?)?.toInt(),
      pincode: json['pincode'] as String?,
      legs: json['legs'] as String?,
      countryCode: json['countryCode'] as String?,
      emailID: json['emailID'] as String?,
      isSeller: json['isSeller'] as bool? ?? true,
    );

Map<String, dynamic> _$UserCreateSignupToJson(UserCreateSignup instance) =>
    <String, dynamic>{
      'referalID': instance.referalID,
      'referalIDstr': instance.referalIDstr,
      'address': instance.address,
      'mobileNo': instance.mobileNo,
      'name': instance.name,
      'outletName': instance.outletName,
      'roleID': instance.roleID,
      'pincode': instance.pincode,
      'legs': instance.legs,
      'countryCode': instance.countryCode,
      'emailID': instance.emailID,
      'isSeller': instance.isSeller,
    };
