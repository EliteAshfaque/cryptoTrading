// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generateUserAddress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerateUserAddressApiStruct _$GenerateUserAddressApiStructFromJson(
        Map<String, dynamic> json) =>
    GenerateUserAddressApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$GenerateUserAddressApiStructToJson(
        GenerateUserAddressApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

UserAddressStruct _$UserAddressStructFromJson(Map<String, dynamic> json) =>
    UserAddressStruct(
      uniqueId: json['uniqueId'] as String?,
      id: json['_id'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      network: json['network'] as String?,
    );

Map<String, dynamic> _$UserAddressStructToJson(UserAddressStruct instance) =>
    <String, dynamic>{
      'address': instance.address,
      'network': instance.network,
      'email': instance.email,
      'uniqueId': instance.uniqueId,
      '_id': instance.id,
    };
