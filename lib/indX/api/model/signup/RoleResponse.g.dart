// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RoleResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoleResponse _$RoleResponseFromJson(Map<String, dynamic> json) => RoleResponse(
      statuscode: (json['statuscode'] as num?)?.toInt(),
      msg: json['msg'] as String?,
      refferalLink: json['refferalLink'] as String?,
      isBinaryon: (json['isBinaryon'] as num?)?.toInt(),
      isAppValid: json['isAppValid'] as bool?,
      isVersionValid: json['isVersionValid'] as bool?,
      isReferralEditable: json['isReferralEditable'] as bool?,
      isCountryCodeRequired: json['isCountryCodeRequired'] as bool?,
      name: json['name'] as String?,
      legs: json['legs'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
      signupRefferalId: (json['signupRefferalId'] as num?)?.toInt(),
      childRoles: (json['childRoles'] as List<dynamic>?)
          ?.map((e) => ChildRoles.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoleResponseToJson(RoleResponse instance) =>
    <String, dynamic>{
      'statuscode': instance.statuscode,
      'msg': instance.msg,
      'refferalLink': instance.refferalLink,
      'isBinaryon': instance.isBinaryon,
      'isAppValid': instance.isAppValid,
      'isVersionValid': instance.isVersionValid,
      'isReferralEditable': instance.isReferralEditable,
      'isCountryCodeRequired': instance.isCountryCodeRequired,
      'name': instance.name,
      'legs': instance.legs,
      'userId': instance.userId,
      'signupRefferalId': instance.signupRefferalId,
      'childRoles': instance.childRoles,
    };
