// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DetailsByUserIdResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailsByUserIdResponse _$DetailsByUserIdResponseFromJson(
        Map<String, dynamic> json) =>
    DetailsByUserIdResponse(
      name: json['name'] as String?,
      mobile: json['mobile'] as String?,
      emailId: json['emailId'] as String?,
      msg: json['msg'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
      statuscode: (json['statuscode'] as num?)?.toInt(),
      isVersionValid: json['isVersionValid'] as bool?,
    );

Map<String, dynamic> _$DetailsByUserIdResponseToJson(
        DetailsByUserIdResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mobile': instance.mobile,
      'emailId': instance.emailId,
      'msg': instance.msg,
      'userId': instance.userId,
      'statuscode': instance.statuscode,
      'isVersionValid': instance.isVersionValid,
    };
