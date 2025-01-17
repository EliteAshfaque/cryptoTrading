// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledgerEntries.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LedgerEntriesApiStruct _$LedgerEntriesApiStructFromJson(
        Map<String, dynamic> json) =>
    LedgerEntriesApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$LedgerEntriesApiStructToJson(
        LedgerEntriesApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

LedgerEntryApiResp _$LedgerEntryApiRespFromJson(Map<String, dynamic> json) =>
    LedgerEntryApiResp(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => LedgerStruct.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LedgerEntryApiRespToJson(LedgerEntryApiResp instance) =>
    <String, dynamic>{
      'data': instance.data,
      'totalCount': instance.totalCount,
    };

LedgerStruct _$LedgerStructFromJson(Map<String, dynamic> json) => LedgerStruct(
      uniqueId: json['uniqueId'] as String?,
      txId: json['txId'] as String?,
      symbol: json['symbol'] as String?,
      type: json['type'] as String?,
      createdAt: (json['createdAt'] as num?)?.toInt(),
      email: json['email'] as String?,
      amount: json['amount'] as String?,
      utrNo: json['utrNo'] as String?,
      charge: json['charge'] as String?,
      closingBalance: json['closingBalance'] as String?,
      openingBalance: json['openingBalance'] as String?,
      referenceId: json['referenceId'] as String?,
      remarks: json['remarks'] as String?,
      requestId: json['requestId'] as String?,
      transactionType: json['transactionType'] as String?,
    );

Map<String, dynamic> _$LedgerStructToJson(LedgerStruct instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'txId': instance.txId,
      'referenceId': instance.referenceId,
      'charge': instance.charge,
      'openingBalance': instance.openingBalance,
      'amount': instance.amount,
      'createdAt': instance.createdAt,
      'email': instance.email,
      'closingBalance': instance.closingBalance,
      'type': instance.type,
      'remarks': instance.remarks,
      'uniqueId': instance.uniqueId,
      'symbol': instance.symbol,
      'transactionType': instance.transactionType,
      'utrNo': instance.utrNo,
    };
