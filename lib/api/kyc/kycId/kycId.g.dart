// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kycId.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KycIdApiStruct _$KycIdApiStructFromJson(Map<String, dynamic> json) =>
    KycIdApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$KycIdApiStructToJson(KycIdApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

KycStruct _$KycStructFromJson(Map<String, dynamic> json) => KycStruct(
      uniqueId: json['uniqueId'] as String?,
      email: json['email'] as String?,
      createdAt: json['createdAt'] as String?,
      originalOrderQty: json['originalOrderQty'] as String?,
      orderPrice: json['orderPrice'] as String?,
      status: json['status'] as String?,
      aadhaarBackDocId: json['aadhaarBackDocId'] as String?,
      aadhaarFrontDocId: json['aadhaarFrontDocId'] as String?,
      aadhaarNumber: json['aadhaarNumber'] as String?,
      docsArr: (json['docsArr'] as List<dynamic>?)
          ?.map((e) => KycDocsArr.fromJson(e as Map<String, dynamic>))
          .toList(),
      failedReason: json['failedReason'] as String?,
      panDocId: json['panDocId'] as String?,
      panNumber: json['panNumber'] as String?,
      userDocId: json['userDocId'] as String?,
      userImgId: json['userImgId'] as String?,
    );

Map<String, dynamic> _$KycStructToJson(KycStruct instance) => <String, dynamic>{
      'failedReason': instance.failedReason,
      'email': instance.email,
      'aadhaarBackDocId': instance.aadhaarBackDocId,
      'aadhaarFrontDocId': instance.aadhaarFrontDocId,
      'createdAt': instance.createdAt,
      'docsArr': instance.docsArr,
      'panDocId': instance.panDocId,
      'status': instance.status,
      'uniqueId': instance.uniqueId,
      'userDocId': instance.userDocId,
      'userImgId': instance.userImgId,
      'aadhaarNumber': instance.aadhaarNumber,
      'panNumber': instance.panNumber,
      'originalOrderQty': instance.originalOrderQty,
      'orderPrice': instance.orderPrice,
    };

KycDocsArr _$KycDocsArrFromJson(Map<String, dynamic> json) => KycDocsArr(
      status: json['status'] as bool?,
      docType: json['docType'] as String?,
    );

Map<String, dynamic> _$KycDocsArrToJson(KycDocsArr instance) =>
    <String, dynamic>{
      'docType': instance.docType,
      'status': instance.status,
    };
