// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactionLogHistory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionLogHistoryApiStruct _$TransactionLogHistoryApiStructFromJson(
        Map<String, dynamic> json) =>
    TransactionLogHistoryApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$TransactionLogHistoryApiStructToJson(
        TransactionLogHistoryApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

TransactionLogHistoryApiResp _$TransactionLogHistoryApiRespFromJson(
        Map<String, dynamic> json) =>
    TransactionLogHistoryApiResp(
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => TransactionLogsStruct.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TransactionLogHistoryApiRespToJson(
        TransactionLogHistoryApiResp instance) =>
    <String, dynamic>{
      'data': instance.data,
      'totalCount': instance.totalCount,
    };

TransactionLogsStruct _$TransactionLogsStructFromJson(
        Map<String, dynamic> json) =>
    TransactionLogsStruct(
      status: json['status'] as String?,
      uniqueId: json['uniqueId'] as String?,
      email: json['email'] as String?,
      symbol: json['symbol'] as String?,
      contractAddress: json['contractAddress'] as String?,
      message: json['message'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      deductedAmt: json['deductedAmt'] as String?,
      finalAmount: json['finalAmount'] as String?,
      fromAddress: json['fromAddress'] as String?,
      requestType: json['requestType'] as String?,
      toAddress: json['toAddress'] as String?,
      transactionHash: json['transactionHash'] as String?,
      transferFrom: json['transferFrom'] as String?,
      updatedAt: json['updatedAt'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$TransactionLogsStructToJson(
        TransactionLogsStruct instance) =>
    <String, dynamic>{
      'fromAddress': instance.fromAddress,
      'toAddress': instance.toAddress,
      'contractAddress': instance.contractAddress,
      'status': instance.status,
      'requestType': instance.requestType,
      'transactionHash': instance.transactionHash,
      'amount': instance.amount,
      'email': instance.email,
      'symbol': instance.symbol,
      'uniqueId': instance.uniqueId,
      'deductedAmt': instance.deductedAmt,
      'finalAmount': instance.finalAmount,
      'message': instance.message,
      'transferFrom': instance.transferFrom,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
