// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allRequests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllRequestApiStruct _$AllRequestApiStructFromJson(Map<String, dynamic> json) =>
    AllRequestApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$AllRequestApiStructToJson(
        AllRequestApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

AllRequestApiResp _$AllRequestApiRespFromJson(Map<String, dynamic> json) =>
    AllRequestApiResp(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => RequestStruct.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AllRequestApiRespToJson(AllRequestApiResp instance) =>
    <String, dynamic>{
      'data': instance.data,
      'totalCount': instance.totalCount,
    };

RequestStruct _$RequestStructFromJson(Map<String, dynamic> json) =>
    RequestStruct(
      balance: (json['balance'] as num?)?.toDouble(),
      failedReason: json['failedReason'] as String?,
      atmNo: json['atmNo'] as String?,
      txnNo: json['txnNo'] as String?,
      uniqueId: json['uniqueId'] as String?,
      email: json['email'] as String?,
      createdAt: (json['createdAt'] as num?)?.toInt(),
      status: json['status'] as String?,
      bankId: json['bankId'] as String?,
      docId: json['docId'] as String?,
      imagePath: json['imagePath'] as String?,
      paymentMode: json['paymentMode'] as String?,
      utrNo: json['utrNo'] as String?,
      walletId: json['walletId'] as String?,
      updatedAt: json['updatedAt'] as String?,
      remark: json['remark'] as String? ?? "",
    );

Map<String, dynamic> _$RequestStructToJson(RequestStruct instance) =>
    <String, dynamic>{
      'bankId': instance.bankId,
      'paymentMode': instance.paymentMode,
      'failedReason': instance.failedReason,
      'atmNo': instance.atmNo,
      'txnNo': instance.txnNo,
      'utrNo': instance.utrNo,
      'balance': instance.balance,
      'docId': instance.docId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'email': instance.email,
      'status': instance.status,
      'uniqueId': instance.uniqueId,
      'walletId': instance.walletId,
      'imagePath': instance.imagePath,
      'remark': instance.remark,
    };
