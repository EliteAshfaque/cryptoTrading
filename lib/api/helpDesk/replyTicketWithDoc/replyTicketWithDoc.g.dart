// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replyTicketWithDoc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplyTicketWithDocApiStruct _$ReplyTicketWithDocApiStructFromJson(
        Map<String, dynamic> json) =>
    ReplyTicketWithDocApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$ReplyTicketWithDocApiStructToJson(
        ReplyTicketWithDocApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };
