// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userAdditionalDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAdditionalDetailsApiStruct _$UserAdditionalDetailsApiStructFromJson(
        Map<String, dynamic> json) =>
    UserAdditionalDetailsApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$UserAdditionalDetailsApiStructToJson(
        UserAdditionalDetailsApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

UserDetailsStruct _$UserDetailsStructFromJson(Map<String, dynamic> json) =>
    UserDetailsStruct(
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      uniqueId: json['uniqueId'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      kycVerified: json['kycVerified'] as bool?,
      postalCode: json['postalCode'] as String?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$UserDetailsStructToJson(UserDetailsStruct instance) =>
    <String, dynamic>{
      'email': instance.email,
      'address': instance.address,
      'city': instance.city,
      'country': instance.country,
      'postalCode': instance.postalCode,
      'state': instance.state,
      'uniqueId': instance.uniqueId,
      'phone': instance.phone,
      'name': instance.name,
      'kycVerified': instance.kycVerified,
    };
